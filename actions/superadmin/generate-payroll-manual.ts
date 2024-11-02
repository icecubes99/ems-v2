'use server'
import * as z from "zod";

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth"
import { auditAction } from "../auditAction"
import { getUserById } from '@/data/user'
import { superAdmin } from './superAdmin'
import { AddEmployeeToPayrollCalculatedSchema, PayrollFirstsStep } from '@/schemas/payroll-index'
import { startOfDay, endOfDay, subMonths, setDate, differenceInMinutes, subDays } from "date-fns"
import { calculateGovernmentContributions } from "./generate-payroll";
import { Status } from "@prisma/client";

export async function generatePayrollManual(values: z.infer<typeof PayrollFirstsStep>) {
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

        const validatedFields = PayrollFirstsStep.safeParse(values);
        if (!validatedFields.success) {
            return { error: "Invalid Fields!" }
        }

        const { payPeriodEnd: payPeriodEndDate, payPeriodStart: payPeriodStartDate } = validatedFields.data;

        const payPeriodStart = startOfDay(new Date(payPeriodStartDate));
        const payPeriodEnd = endOfDay(new Date(payPeriodEndDate));

        const existingPayroll = await db.payroll.findFirst({
            where: {
                payPeriodStart,
                payPeriodEnd
            }
        });

        if (existingPayroll) {
            return { error: "A payroll for this period already exists!" };
        }

        const overlappingPayroll = await db.payroll.findFirst({
            where: {
                OR: [
                    {
                        payPeriodStart: {
                            lte: payPeriodEnd
                        },
                        payPeriodEnd: {
                            gte: payPeriodStart
                        }
                    }
                ]
            }
        });

        if (overlappingPayroll) {
            return { error: "A payroll for this period already exists!" };
        }

        const newPayroll = await db.payroll.create({
            data: {
                payPeriodStart,
                payPeriodEnd,
                totalAmount: 0,
            }
        })

        let pps = new Date(payPeriodStart);
        let ppe = new Date(payPeriodEnd);

        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(user.id, `Payroll generated for period ${pps.toLocaleDateString()} to ${ppe.toLocaleDateString()} by SuperAdmin: ${superAdminName}`);


        return { success: "Payroll generated successfully!", payrollId: newPayroll.id };

    } catch (error) {
        console.error("Error generating payroll:", error);
        return { error: "Failed to generate payroll. Please check server logs for details." };
    }
} export async function addEmployeeToPayrollCalculated(payrollId: string, values: z.infer<typeof AddEmployeeToPayrollCalculatedSchema>) {
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

    // Step 3: Check if the user is a superadmin
    const superadminResult = await superAdmin();
    if (superadminResult.error) {
        return { error: superadminResult.error }
    }

    // Step 4: Validate the input fields
    const validatedFields = AddEmployeeToPayrollCalculatedSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid Fields!" }
    }

    const { userIds } = validatedFields.data;

    // Step 5: Get the payroll record
    const payroll = await db.payroll.findFirst({
        where: {
            id: payrollId
        }
    });

    if (!payroll) {
        return { error: "Payroll not found!" };
    }

    // Step 6: Process each user ID
    for (const userId of userIds) {
        // Step 6.1: Check if the payroll item already exists
        const existingPayrollItem = await db.payrollItem.findFirst({
            where: {
                payrollId,
                userId
            }
        });

        if (existingPayrollItem) {
            return { error: "Employee already added to payroll!" };
        }

        const payPeriodStart = new Date(payroll.payPeriodStart);
        const payPeriodEnd = new Date(payroll.payPeriodEnd);

        // Step 6.2: Get the working days within the pay period
        const workingDays = await db.workingDay.findMany({
            where: {
                date: {
                    gte: payPeriodStart,
                    lte: payPeriodEnd
                }
            }
        });

        const nonRequiredWorkingDays = await db.workingDay.findMany({
            where: {
                date: {
                    gte: payPeriodStart,
                    lte: payPeriodEnd
                },
                isRequired: false
            }
        });

        const totalWorkingDays = workingDays.length;

        // Step 6.3: Get the employee details
        const employee = await db.user.findFirst({
            where: {
                id: userId
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

        if (!employee) {
            return { error: "Employee not found!" };
        }

        const { userSalary, timesheets, additionalEarnings, deductions, governmentId, salaryHistories } = employee;
        if (!userSalary || !governmentId) {
            console.error(`Employee ${employee.id} has no salary information or government IDs.`);
            return { error: "Employee has no salary information or government IDs." };
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
        const basicSalaryForDeduction = userSalary.basicSalary;
        const grossSalaryForDeduction = userSalary.grossSalary;
        const overtimeSalary = overtimeMinutes * minuteRate * 1.5; // 1.5x rate for overtime

        const notWorkedDeduction = minutesNotWorked * minuteRate;
        const partialAdditionalEarnings = additionalEarnings.reduce((sum, earning) => sum + earning.amount, 0);
        const allowances = employee.allowances;
        const totalAdditionalEarnings = partialAdditionalEarnings + allowances.reduce((sum, allowance) => sum + allowance.amount, 0);

        let totalDeductions = deductions.reduce((sum, deduction) => sum + deduction.amount, 0) + notWorkedDeduction;

        // Step 6.5: Calculate government contributions
        const governmentContributions = await calculateGovernmentContributions(grossSalaryForDeduction || basicSalaryForDeduction);

        const totalGovernmentDeductions = governmentContributions.reduce((sum, contrib) => sum + contrib.amount, 0);
        totalDeductions += totalGovernmentDeductions;

        let netSalary = basicSalary + overtimeSalary + totalAdditionalEarnings + specialDayEarnings - totalDeductions;
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
            netSalary,

        });

        if (isNaN(netSalary)) {
            console.error(`Invalid net salary calculation for employee ${employee.id}`);
            return { error: "Invalid net salary calculation." };
        }

        // Step 6.6: Use a transaction to ensure data consistency
        await db.$transaction(async (prisma) => {
            // Step 6.6.1: Create the PayrollItem
            const payrollItem = await prisma.payrollItem.create({
                data: {
                    payrollId: payroll.id,
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
                    minutesEarlyOut: totalEarlyOutMinutes,
                    daysLeave: leaveDaysCount,
                    specialDayMinutes,
                    specialDayEarnings,
                }
            });

            // Step 6.6.2: Create deductions for government contributions
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

            // Step 6.6.3: Create the Additional Earnings for allowance if there is an allowance
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

            // Step 6.6.4: Update AdditionalEarnings with the new payrollItemId
            await prisma.additionalEarnings.updateMany({
                where: {
                    userId: employee.id,
                    createdAt: {
                        gte: payPeriodStart,
                        lte: payPeriodEnd
                    },
                    payrollItemId: null
                },
                data: {
                    payrollItemId: payrollItem.id
                }
            });

            // Step 6.6.5: Update Timesheets with the new payrollItemId
            await prisma.timesheet.updateMany({
                where: {
                    userId: employee.id,
                    day: {
                        date: {
                            gte: payPeriodStart,
                            lte: payPeriodEnd
                        }
                    },
                    payrollItemId: null
                },
                data: {
                    payrollItemId: payrollItem.id
                }
            });

            // Step 6.6.6: Update Deductions with the new payrollItemId
            await prisma.deductions.updateMany({
                where: {
                    userId: employee.id,
                    createdAt: {
                        gte: payPeriodStart,
                        lte: payPeriodEnd
                    },
                    payrollItemId: null
                },
                data: {
                    payrollItemId: payrollItem.id
                }
            });

            // Step 18: Create DaysNotWorked entries
            const daysNotWorkedEntries = [];
            const allDaysInPeriod = [];
            for (let d = new Date(payPeriodStart); d <= payPeriodEnd; d.setDate(d.getDate() + 1)) {
                allDaysInPeriod.push(new Date(d));
            }

            for (const day of allDaysInPeriod) {
                const isWorkingDay = workingDays.some(wd => wd.date.getTime() === day.getTime());
                const hasTimesheet = timesheets.some(ts => ts.day.date.getTime() === day.getTime());

                if (isWorkingDay && !hasTimesheet) {
                    daysNotWorkedEntries.push({
                        date: day,
                        userId: employee.id,
                        payrollItemId: payrollItem.id,
                    });
                }
            }

            await prisma.daysNotWorked.createMany({
                data: daysNotWorkedEntries
            });

            // Step 6.6.7: Update the total amount in the payroll
            await prisma.payroll.update({
                where: {
                    id: payrollId
                },
                data: {
                    totalAmount: {
                        increment: netSalary
                    }
                }
            })
        });
    }

    // Step 7: Audit the action
    const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
    await auditAction(user.id, `Employees added to Payroll by SuperAdmin: ${superAdminName}`);

    // Step 8: Return success message
    return { success: "Employee added to payroll successfully!" };
}

export async function addEmployeeToPayrollManual() {

}

export async function addMultipleEmployeesToPayrollCalculated() {

}