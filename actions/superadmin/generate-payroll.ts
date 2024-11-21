'use server'

import { prisma } from '@/lib/prisma'
import { currentUser } from "@/lib/auth"
import { auditAction } from "../auditAction"
import { startOfDay, endOfDay, subMonths, setDate, differenceInMinutes } from "date-fns"
import { getUserById } from '@/data/user'
import { superAdmin } from './superAdmin'
import { Status } from '@prisma/client'
export async function generatePayroll() {
    try {
        // Step 1: Get the current user
        const user = await currentUser();
        if (!user) {
            return { error: "Unauthorized!" };
        }

        // Step 2: Get the user from the database
        const dbUser = await getUserById(user.id);
        if (!dbUser) {
            return { error: "User not found in database!" }
        }

        // Step 3: Check if the user is a super admin
        const superadminResult = await superAdmin();
        if (superadminResult.error) {
            return { error: superadminResult.error }
        }

        // Step 4: Determine the pay period start and end dates
        const today = new Date();
        let payPeriodStart: Date;
        let payPeriodEnd: Date;

        if (today.getDate() >= 11 && today.getDate() <= 15) {
            payPeriodStart = startOfDay(setDate(subMonths(today, 1), 26));
            payPeriodEnd = endOfDay(setDate(today, 10));
        } else if (today.getDate() >= 26 && today.getDate() <= 31) {
            payPeriodStart = startOfDay(setDate(today, 11));
            payPeriodEnd = endOfDay(setDate(today, 25));
        } else {
            return { error: "Payroll can only be generated between the 11th-15th or 26th-31st of the month." };
        }

        // Step 5: Check if Prisma client is initialized
        if (!prisma) {
            throw new Error('Prisma client is not initialized');
        }

        // Step 6: Check if a payroll for the current period already exists
        const existingPayroll = await prisma.payroll.findFirst({
            where: {
                payPeriodStart,
                payPeriodEnd
            }
        });

        if (existingPayroll) {
            return { error: "A payroll for this period already exists!" };
        }

        // Step 7: Create a new payroll record
        const newPayroll = await prisma.payroll.create({
            data: {
                payPeriodStart,
                payPeriodEnd,
                payrollStatus: "PENDING",
                totalAmount: 0,
            }
        });

        // Step 8: Get the working days within the pay period
        const workingDays = await prisma.workingDay.findMany({
            where: {
                date: {
                    gte: payPeriodStart,
                    lte: payPeriodEnd
                },
                isRequired: true
            }
        });

        const nonRequiredWorkingDays = await prisma.workingDay.findMany({
            where: {
                date: {
                    gte: payPeriodStart,
                    lte: payPeriodEnd
                },
                isRequired: false
            }
        });

        const totalWorkingDays = workingDays.length;

        // Step 9: Get all employees with salary information
        const employees = await prisma.user.findMany({
            where: {
                userSalary: {
                    isNot: null
                },
                department: {
                    status: Status.ACTIVE
                },
                designation: {
                    status: Status.ACTIVE
                },
            },
            include: {
                userSalary: true,
                timesheets: {
                    where: {
                        day: {
                            date: {
                                gte: payPeriodStart,
                                lte: payPeriodEnd
                            }
                        }
                    },
                    include: {
                        day: true
                    }
                },
                additionalEarnings: {
                    where: {
                        createdAt: {
                            gte: payPeriodStart,
                            lte: payPeriodEnd
                        }
                    }
                },
                deductions: {
                    where: {
                        createdAt: {
                            gte: payPeriodStart,
                            lte: payPeriodEnd
                        }
                    }
                },
                governmentId: {
                    where: {
                        NOT: {
                            sssNumber: null,
                            pagIbigNumber: null,
                            philHealthNumber: null,
                            tinNumber: null
                        }
                    }
                },
                allowances: {
                    where: {
                        OR: [
                            {
                                startDate: {
                                    lte: payPeriodEnd
                                },
                                endDate: {
                                    gte: payPeriodStart
                                }
                            },
                            {
                                startDate: {
                                    gte: payPeriodStart,
                                    lte: payPeriodEnd
                                }
                            },
                            {
                                endDate: {
                                    gte: payPeriodStart,
                                    lte: payPeriodEnd
                                }
                            }
                        ],
                        status: Status.ACTIVE
                    }
                },
                salaryHistories: {
                    where: {
                        startDate: {
                            lte: payPeriodEnd
                        },
                        endDate: {
                            gte: payPeriodStart
                        }
                    }
                }
            }
        });

        let totalPayrollAmount = 0;

        // Step 10: Process each employee's payroll
        for (const employee of employees) {
            const { userSalary, timesheets, additionalEarnings, deductions, governmentId, salaryHistories } = employee;
            if (!userSalary || !governmentId) {
                console.error(`Employee ${employee.id} has no salary information or government IDs.`);
                continue;
            }

            // Determine the salary to use based on salaryHistories
            let grossSalary = userSalary.grossSalary || userSalary.basicSalary;
            if (salaryHistories.length > 0) {
                const relevantHistory = salaryHistories.find(history => history.endDate >= payPeriodStart && history.startDate <= payPeriodEnd);
                if (relevantHistory) {
                    if (relevantHistory.endDate < payPeriodEnd) {
                        // If the endDate of the salaryHistory is within the pay period, use the userSalary after the endDate
                        grossSalary = userSalary.grossSalary || userSalary.basicSalary;
                    } else {
                        // Use the salary from the salaryHistory
                        grossSalary = relevantHistory.grossSalary;
                    }
                }
            }

            const dailyRate = grossSalary / totalWorkingDays;
            const minuteRate = dailyRate / 600; // Assuming 10 working hours per day
            let totalMinutesWorked = 0;
            let totalLateMinutes = 0;
            let totalEarlyOutMinutes = 0;
            let overtimeMinutes = 0;
            let daysWorked = 0;
            let leaveDaysCount = 0;

            let specialDayMinutes = 0;
            let specialDayEarnings = 0;

            // Step 11: Process each timesheet for the employee
            for (const timesheet of timesheets) {
                if (!timesheet.clockOut) {
                    console.warn(`Timesheet ${timesheet.id} for employee ${employee.id} has no clock out time.`);
                    continue;
                }
                if (timesheet.isLeave) {
                    leaveDaysCount++;
                }

                const clockIn = new Date(timesheet.clockIn);
                const clockOut = new Date(timesheet.clockOut);

                let dailyMinutes = Math.min(600, Math.max(0, differenceInMinutes(clockOut, clockIn)));
                totalMinutesWorked += dailyMinutes;

                totalEarlyOutMinutes += timesheet.clockOutEarlyMinutes;
                totalLateMinutes += timesheet.minutesLate;

                if (timesheet.isOvertime) {
                    overtimeMinutes += timesheet.minutesOvertime;
                }

                daysWorked++;
            }

            // Process timesheets for non-required working days
            for (const timesheet of timesheets) {
                if (!timesheet.clockOut) continue;

                const workingDay = nonRequiredWorkingDays.find(day =>
                    day.date.getTime() === timesheet.day.date.getTime()
                );

                if (workingDay) {
                    const clockIn = new Date(timesheet.clockIn);
                    const clockOut = new Date(timesheet.clockOut);

                    // Calculate minutes worked on special day
                    const minutesWorked = Math.min(600, Math.max(0, differenceInMinutes(clockOut, clockIn)));
                    specialDayMinutes += minutesWorked;

                    // Calculate earnings for special day (2x rate)
                    const specialDayRate = dailyRate * 2;
                    const specialDayMinuteRate = specialDayRate / 600;
                    specialDayEarnings += minutesWorked * specialDayMinuteRate;

                    // Add overtime if applicable (2.5x rate for special day overtime)
                    if (timesheet.isOvertime) {
                        const overtimeRate = minuteRate * 2.5;
                        specialDayEarnings += timesheet.minutesOvertime * overtimeRate;
                    }
                }
            }

            const daysNotWorked = totalWorkingDays - daysWorked;
            const minutesNotWorked = (daysNotWorked * 600) + totalLateMinutes + totalEarlyOutMinutes;

            const basicSalary = daysWorked * dailyRate;
            const basicSalaryForDeduction = userSalary.basicSalary
            const grossSalaryForDeduction = userSalary.grossSalary
            const overtimeSalary = overtimeMinutes * minuteRate * 1.5; // 1.5x rate for overtime
            const notWorkedDeduction = minutesNotWorked * minuteRate;

            const partialAdditionalEarnings = additionalEarnings.reduce((sum, earning) => sum + earning.amount, 0);
            const allowances = employee.allowances;
            const totalAdditionalEarnings = partialAdditionalEarnings + allowances.reduce((sum, allowance) => sum + allowance.amount, 0);

            const lateDeduction = totalLateMinutes * minuteRate;
            const earlyOutDeduction = totalEarlyOutMinutes * minuteRate;
            const absentDeduction = (daysNotWorked * 600) * minuteRate;

            const governmentContributions = await calculateGovernmentContributions(grossSalaryForDeduction || basicSalaryForDeduction);

            // Step 13: Update total deductions
            const totalGovernmentDeductions = governmentContributions.reduce((sum, contrib) => sum + contrib.amount, 0);

            let totalDeductions =
                deductions.reduce((sum, deduction) => sum + deduction.amount, 0) + // Manual deductions
                lateDeduction +                                                     // Late deductions
                earlyOutDeduction +                                                // Early out deductions
                absentDeduction +                                                 // Absent days deductions
                totalGovernmentDeductions;

            let netSalary = basicSalary + overtimeSalary + totalAdditionalEarnings + specialDayEarnings - totalDeductions;
            netSalary = Math.max(0, netSalary);


            let updatedNetSalary = (employee.userSalary?.grossSalary || basicSalary) - totalDeductions

            console.log(`Employee ${employee.id}:`, {
                totalWorkingDays,
                daysWorked,
                daysNotWorked,
                dailyRate,
                basicSalary,
                totalMinutesWorked,
                minutesNotWorked,
                overtimeMinutes,
                overtimeSalary,
                totalLateMinutes,
                totalEarlyOutMinutes,
                notWorkedDeduction,
                totalAdditionalEarnings,
                totalDeductions,
                netSalary
            });

            if (isNaN(netSalary)) {
                console.error(`Invalid net salary calculation for employee ${employee.id}`);
                continue;
            }

            // Step 15: Use a transaction to ensure data consistency
            await prisma.$transaction(async (prisma) => {
                // Create the PayrollItem
                const payrollItem = await prisma.payrollItem.create({
                    data: {
                        payrollId: newPayroll.id,
                        userId: employee.id,
                        basicSalary: employee.userSalary?.grossSalary || basicSalary,
                        overtimeSalary,
                        dailyRate,
                        additionalEarnings: totalAdditionalEarnings,
                        lateDeductions: totalLateMinutes * minuteRate,
                        earlyClockOutDeductions: totalEarlyOutMinutes * minuteRate,
                        totalDeductions,
                        netSalary: updatedNetSalary,
                        daysWorked,
                        daysNotWorked,
                        minutesWorked: totalMinutesWorked,
                        minutesNotWorked,
                        minutesLate: totalLateMinutes,
                        minutesOvertime: overtimeMinutes,
                        minutesEarlyOut: totalEarlyOutMinutes,
                        daysLeave: leaveDaysCount,
                        specialDayMinutes,
                        specialDayEarnings,
                    }
                });

                // Create deductions for government contributions
                await Promise.all(governmentContributions.map(contribution =>
                    prisma.deductions.create({
                        data: {
                            userId: employee.id,
                            deductionType: contribution.type,
                            amount: contribution.amount,
                            description: `${contribution.type} contribution`,
                            payrollItemId: payrollItem.id,
                        }
                    })
                ));

                // Create the Additional Earnings for allowance if there is an allowance
                const allowances = employee.allowances;
                if (allowances.length > 0) {
                    for (const allowance of allowances) {
                        await prisma.additionalEarnings.create({
                            data: {
                                userId: employee.id,
                                amount: allowance.amount,
                                earningType: allowance.type,
                                description: "Allowance",
                                payrollItemId: payrollItem.id,
                            }
                        });
                    }
                }

                // Update AdditionalEarnings with the new payrollItemId
                await prisma.additionalEarnings.updateMany({
                    where: {
                        userId: employee.id,
                        createdAt: {
                            gte: payPeriodStart,
                            lte: payPeriodEnd
                        },
                        payrollItemId: null // Only update if not already assigned
                    },
                    data: {
                        payrollItemId: payrollItem.id
                    }
                });

                // Update Timesheets with the new payrollItemId
                await prisma.timesheet.updateMany({
                    where: {
                        userId: employee.id,
                        day: {
                            date: {
                                gte: payPeriodStart,
                                lte: payPeriodEnd
                            }
                        },
                        payrollItemId: null // Only update if not already assigned
                    },
                    data: {
                        payrollItemId: payrollItem.id
                    }
                });

                // Update Deductions with the new payrollItemId
                await prisma.deductions.updateMany({
                    where: {
                        userId: employee.id,
                        createdAt: {
                            gte: payPeriodStart,
                            lte: payPeriodEnd
                        },
                        payrollItemId: null // Only update if not already assigned
                    },
                    data: {
                        payrollItemId: payrollItem.id
                    }
                });
            });

            totalPayrollAmount += updatedNetSalary;
        }

        // Step 16: Update the total amount for the payroll
        await prisma.payroll.update({
            where: { id: newPayroll.id },
            data: { totalAmount: totalPayrollAmount }
        });

        // Step 17: Audit the payroll generation action
        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(user.id, `Payroll generated for period ${payPeriodStart.toLocaleDateString()} to ${payPeriodEnd.toLocaleDateString()} by SuperAdmin: ${superAdminName}`);

        return { success: "Payroll generated successfully!", payrollId: newPayroll.id };
    } catch (error) {
        console.error("Error generating payroll:", error);
        return { error: "Failed to generate payroll. Please check server logs for details." };
    }
}

export interface SSSBracket {
    table: [number, number, number][];
}

export interface ContributionRule {
    minSalary?: number;
    maxSalary?: number;
    rate?: number;
    contribution?: number;
    deduction?: number;
}

export interface OtherContributionBracket {
    rules: ContributionRule[];
}

export type ContributionBracket = SSSBracket | OtherContributionBracket;

export interface GovernmentContribution {
    id: string;
    type: string;
    brackets: ContributionBracket;
    createdAt: Date;
    updatedAt: Date;
}

export async function calculateGovernmentContributions(basicSalary: number): Promise<Array<{ type: string, amount: number }>> {
    const contributions: Array<{ type: string, amount: number }> = [];
    const contributionTypes = ['SSS', 'PhilHealth', 'PagIBIG', 'Tax'];

    for (const type of contributionTypes) {
        const contributionData = await prisma.governmentContribution.findUnique({
            where: { type },
        }) as GovernmentContribution | null;

        if (!contributionData || !contributionData.brackets) {
            console.error(`Contribution data for ${type} not found or invalid`);
            continue;
        }

        let amount = 0;

        switch (type) {
            case 'SSS':
                amount = calculateSSS(basicSalary, (contributionData.brackets as SSSBracket).table);
                break;
            case 'PhilHealth':
                amount = calculatePhilHealth(basicSalary, (contributionData.brackets as OtherContributionBracket).rules);
                break;
            case 'PagIBIG':
                amount = calculatePagIBIG(basicSalary, (contributionData.brackets as OtherContributionBracket).rules);
                break;
            case 'Tax':
                amount = calculateTax(basicSalary, (contributionData.brackets as OtherContributionBracket).rules);
                break;
        }

        contributions.push({ type, amount });
    }

    return contributions;
}

function calculateSSS(salary: number, table: [number, number, number][]): number {
    if (!table || table.length === 0) {
        console.error('SSS table is empty or undefined');
        return 0;
    }

    for (const [min, max, contribution] of table) {
        if (salary >= min && salary <= max) {
            return contribution;
        }
    }
    return table[table.length - 1][2]; // Return the last contribution amount if salary exceeds all brackets
}

function calculatePhilHealth(salary: number, rules: ContributionRule[]): number {
    if (!rules || rules.length === 0) {
        console.error('PhilHealth rules are empty or undefined');
        return 0;
    }

    for (const rule of rules) {
        if (rule.maxSalary && salary <= rule.maxSalary) {
            return rule.contribution || (salary * (rule.rate || 0));
        }
    }
    return rules[rules.length - 1].contribution || 0;
}

function calculatePagIBIG(salary: number, rules: ContributionRule[]): number {
    if (!rules || rules.length === 0) {
        console.error('Pag-IBIG rules are empty or undefined');
        return 0;
    }

    for (const rule of rules) {
        if (rule.maxSalary && salary <= rule.maxSalary) {
            return rule.contribution || (salary * (rule.rate || 0));
        }
    }
    return rules[rules.length - 1].contribution || 0;
}

function calculateTax(salary: number, rules: ContributionRule[]): number {
    if (!rules || rules.length === 0) {
        console.error('Tax rules are empty or undefined');
        return 0;
    }

    for (const rule of rules) {
        if (!rule.maxSalary || salary <= rule.maxSalary) {
            return (salary - (rule.minSalary || 0)) * (rule.rate || 0) + (rule.deduction || 0);
        }
    }
    return 0; // This should never happen if the rules are set up correctly
}