'use server'

import { prisma } from '@/lib/prisma'
import { currentUser } from "@/lib/auth"
import { auditAction } from "../auditAction"
import { startOfDay, endOfDay, subMonths, setDate, differenceInMinutes, subDays } from "date-fns"
import { getUserById } from '@/data/user'
import { superAdmin } from './superAdmin'

export async function generatePayroll() {
    try {
        const user = await currentUser();

        if (!user) {
            return { error: "Unauthorized!" };
        }

        const dbUser = await getUserById(user.id);
        if (!dbUser) {
            return { error: "User not found in database!" }
        }

        const superadminResult = await superAdmin();
        if (superadminResult.error) {
            return { error: superadminResult.error }
        }

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

        if (!prisma) {
            throw new Error('Prisma client is not initialized');
        }

        const existingPayroll = await prisma.payroll.findFirst({
            where: {
                payPeriodStart,
                payPeriodEnd
            }
        });

        if (existingPayroll) {
            return { error: "A payroll for this period already exists!" };
        }

        const newPayroll = await prisma.payroll.create({
            data: {
                payPeriodStart,
                payPeriodEnd,
                payrollStatus: "PENDING",
                totalAmount: 0,
            }
        });

        const workingDays = await prisma.workingDay.findMany({
            where: {
                date: {
                    gte: payPeriodStart,
                    lte: payPeriodEnd
                }
            }
        });

        const totalWorkingDays = workingDays.length;

        const employees = await prisma.user.findMany({
            where: {
                userSalary: {
                    isNot: null
                }
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
                }
            }
        });

        let totalPayrollAmount = 0;

        // Promise.all
        for (const employee of employees) {
            const { userSalary, timesheets, additionalEarnings, deductions, governmentId } = employee;
            if (!userSalary || !governmentId) {
                console.error(`Employee ${employee.id} has no salary information or government IDs.`);
                continue;
            }

            const dailyRate = userSalary.basicSalary / totalWorkingDays;
            const minuteRate = dailyRate / 600; // Assuming 10 working hours per day
            let totalMinutesWorked = 0;
            let totalLateMinutes = 0;
            let totalEarlyOutMinutes = 0;
            let overtimeMinutes = 0;
            let daysWorked = 0;

            // Promise.all
            for (const timesheet of timesheets) {
                if (!timesheet.clockOut) {
                    console.warn(`Timesheet ${timesheet.id} for employee ${employee.id} has no clock out time.`);
                    continue;
                }

                const clockIn = new Date(timesheet.clockIn);
                const clockOut = new Date(timesheet.clockOut);

                let dailyMinutes = Math.min(600, Math.max(0, differenceInMinutes(clockOut, clockIn)));
                totalMinutesWorked += dailyMinutes;

                totalEarlyOutMinutes += timesheet.clockOutEarlyMinutes;
                totalLateMinutes += timesheet.minutesLate;

                if (timesheet.isOvertime) {
                    overtimeMinutes += 60; // Add 60 minutes for each day marked as overtime
                }

                daysWorked++;
            }

            const daysNotWorked = totalWorkingDays - daysWorked;
            const minutesNotWorked = (daysNotWorked * 600) + totalLateMinutes + totalEarlyOutMinutes;

            const basicSalary = daysWorked * dailyRate;
            const basicSalaryForDeduction = userSalary.basicSalary
            const overtimeSalary = overtimeMinutes * minuteRate * 1.5; // 1.5x rate for overtime
            const notWorkedDeduction = minutesNotWorked * minuteRate;

            const totalAdditionalEarnings = additionalEarnings.reduce((sum, earning) => sum + earning.amount, 0);

            let totalDeductions = deductions.reduce((sum, deduction) => sum + deduction.amount, 0) + notWorkedDeduction;

            // Calculate government contributions based on basic salary
            const governmentContributions = calculateGovernmentContributions(basicSalaryForDeduction);

            // Create deductions for government contributions
            const sixDaysAgo = subDays(new Date(), 6);
            // promise.all
            for (const contribution of governmentContributions) {
                await prisma.deductions.create({
                    data: {
                        userId: employee.id,
                        deductionType: contribution.type,
                        amount: contribution.amount,
                        description: `${contribution.type} contribution`,
                        createdAt: sixDaysAgo,
                    }
                });
            }

            // Update total deductions
            const totalGovernmentDeductions = governmentContributions.reduce((sum, contrib) => sum + contrib.amount, 0);
            totalDeductions += totalGovernmentDeductions;

            let netSalary = basicSalary + overtimeSalary + totalAdditionalEarnings - totalDeductions;
            netSalary = Math.max(0, netSalary);

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

            // Use a transaction to ensure data consistency
            await prisma.$transaction(async (prisma) => {
                // Create the PayrollItem
                const payrollItem = await prisma.payrollItem.create({
                    data: {
                        payrollId: newPayroll.id,
                        userId: employee.id,
                        basicSalary,
                        overtimeSalary,
                        dailyRate,
                        additionalEarnings: totalAdditionalEarnings,
                        lateDeductions: totalLateMinutes * minuteRate,
                        earlyClockOutDeductions: totalEarlyOutMinutes * minuteRate,
                        totalDeductions,
                        netSalary,
                        daysWorked,
                        daysNotWorked,
                        minutesWorked: totalMinutesWorked,
                        minutesNotWorked,
                        minutesLate: totalLateMinutes,
                        minutesOvertime: overtimeMinutes,
                        minutesEarlyOut: totalEarlyOutMinutes
                    }
                });

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

            totalPayrollAmount += netSalary;
        }

        // Update the total amount for the payroll
        await prisma.payroll.update({
            where: { id: newPayroll.id },
            data: { totalAmount: totalPayrollAmount }
        });

        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(user.id, `Payroll generated for period ${payPeriodStart.toLocaleDateString()} to ${payPeriodEnd.toLocaleDateString()} by SuperAdmin: ${superAdminName}`);

        return { success: "Payroll generated successfully!", payrollId: newPayroll.id };
    } catch (error) {
        console.error("Error generating payroll:", error);
        return { error: "Failed to generate payroll. Please check server logs for details." };
    }
}

function calculateGovernmentContributions(basicSalary: number): Array<{ type: string, amount: number }> {
    const contributions: Array<{ type: string, amount: number }> = [];

    // SSS Contribution
    const sssTable = [
        [1000, 3249.99, 135],
        [3250, 3749.99, 157.50],
        [3750, 4249.99, 180],
        [4250, 4749.99, 202.5],
        [4750, 5249.99, 225],
        [5250, 5749.99, 247.5],
        [5750, 6249.99, 270],
        [6250, 6749.99, 292.5],
        [6750, 7249.99, 315],
        [7250, 7749.99, 337.5],
        [7750, 8249.99, 360],
        [8250, 8749.99, 382.5],
        [8750, 9249.99, 405],
        [9250, 9749.99, 427.5],
        [9750, 10249.99, 450],
        [10250, 10749.99, 472.5],
        [10750, 11249.99, 495],
        [11250, 11749.99, 517.5],
        [11750, 12249.99, 540],
        [12250, 12749.99, 562.5],
        [12750, 13249.99, 585],
        [13250, 13749.99, 607.5],
        [13750, 14249.99, 630],
        [14250, 14749.99, 652.5],
        [14750, 15249.99, 675],
        [15250, 15749.99, 697.5],
        [15750, 16249.99, 720],
        [16250, 16749.99, 742.5],
        [16750, 17249.99, 765],
        [17250, 17749.99, 787.5],
        [17750, 18249.99, 810],
        [18250, 18749.99, 832.5],
        [18750, 19249.99, 855],
        [19250, 19749.99, 877.5],
        [19750, 20249.99, 900],
        [20250, 20749.99, 922.5],
        [20750, 21249.99, 945],
        [21250, 21749.99, 967.5],
        [21750, 22249.99, 990],
        [22250, 22749.99, 1012.5],
        [22270, 23249.99, 1035],
        [23250, 23749.99, 1057.5],
        [23750, 24249.99, 1080],
        [24250, 24279.99, 1102.5],
        [24750, Infinity, 1125],
    ];

    let sssContribution = 0;
    for (let i = 0; i < sssTable.length; i++) {
        if (basicSalary >= sssTable[i][0] && (i === sssTable.length - 1 || basicSalary <= sssTable[i][1])) {
            sssContribution = sssTable[i][2];
            break;
        }
    }
    contributions.push({ type: 'SSS', amount: sssContribution });

    // PhilHealth Contribution
    let philHealthContribution = 0;
    if (basicSalary <= 10000) {
        philHealthContribution = 450 / 2;
    } else if (basicSalary >= 10000.01 && basicSalary <= 89999.99) {
        philHealthContribution = (basicSalary * 0.05) / 2;
    } else if (basicSalary >= 90000) {
        philHealthContribution = 4050;
    }
    contributions.push({ type: 'PhilHealth', amount: philHealthContribution });

    // Pag-IBIG Contribution
    let pagIbigContribution = 0;
    if (basicSalary <= 1500) {
        pagIbigContribution = basicSalary * 0.01;
    } else if (basicSalary > 1500 && basicSalary < 5000) {
        pagIbigContribution = basicSalary * 0.02;
    } else if (basicSalary >= 5000) {
        pagIbigContribution = 100;
    }
    contributions.push({ type: 'PagIBIG', amount: pagIbigContribution });

    // Tax Calculation
    let taxAmount = 0;
    if (basicSalary <= 20833) {
        taxAmount = 0;
    } else if (basicSalary > 20833 && basicSalary <= 33332) {
        taxAmount = (basicSalary - 20833) * 0.15;
    } else if (basicSalary > 33332 && basicSalary <= 66666) {
        taxAmount = ((basicSalary - 33332) * 0.20) + 1875;
    } else if (basicSalary > 66666 && basicSalary <= 166666) {
        taxAmount = ((basicSalary - 66666) * 0.25) + 8541.8;
    } else if (basicSalary > 166666 && basicSalary <= 666666) {
        taxAmount = ((basicSalary - 166666) * 0.30) + 33541.8;
    } else if (basicSalary > 666666) {
        taxAmount = ((basicSalary - 666666) * 0.35) + 183541.8;
    }
    contributions.push({ type: 'Tax', amount: taxAmount });

    return contributions;
}