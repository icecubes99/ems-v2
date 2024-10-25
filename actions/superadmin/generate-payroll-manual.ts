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
}

export async function addEmployeeToPayrollCalculated(payrollId: string, values: z.infer<typeof AddEmployeeToPayrollCalculatedSchema>) {
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

    const validatedFields = AddEmployeeToPayrollCalculatedSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid Fields!" }
    }

    const { userIds } = validatedFields.data;
    const payroll = await db.payroll.findFirst({
        where: {
            id: payrollId
        }
    });

    if (!payroll) {
        return { error: "Payroll not found!" };
    }
    for (const userId of userIds) {


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

        const workingDays = await db.workingDay.findMany({
            where: {
                date: {
                    gte: payPeriodStart,
                    lte: payPeriodEnd
                }
            }
        });

        const totalWorkingDays = workingDays.length;
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
                }
            }
        });

        if (!employee) {
            return { error: "Employee not found!" };
        }



        const { userSalary, timesheets, additionalEarnings, deductions, governmentId } = employee;
        if (!userSalary || !governmentId) {
            console.error(`Employee ${employee.id} has no salary information or government IDs.`);
            return { error: "Employee has no salary information or government IDs." };
        }

        const dailyRate = (userSalary.grossSalary || userSalary.basicSalary) / totalWorkingDays;
        const minuteRate = dailyRate / 600; // Assuming 10 working hours per day
        let totalMinutesWorked = 0;
        let totalLateMinutes = 0;
        let totalEarlyOutMinutes = 0;
        let overtimeMinutes = 0;
        let daysWorked = 0;
        let leaveDaysCount = 0;

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

        const daysNotWorked = totalWorkingDays - daysWorked;
        const minutesNotWorked = (daysNotWorked * 600) + totalLateMinutes + totalEarlyOutMinutes;

        const basicSalary = daysWorked * dailyRate;
        const basicSalaryForDeduction = userSalary.basicSalary;
        const grossSalaryForDeduction = userSalary.grossSalary;
        const overtimeSalary = overtimeMinutes * minuteRate * 1.5; // 1.5x rate for overtime
        const notWorkedDeduction = minutesNotWorked * minuteRate;

        const totalAdditionalEarnings = additionalEarnings.reduce((sum, earning) => sum + earning.amount, 0);

        let totalDeductions = deductions.reduce((sum, deduction) => sum + deduction.amount, 0) + notWorkedDeduction;

        const governmentContributions = await calculateGovernmentContributions(grossSalaryForDeduction || basicSalaryForDeduction);

        const sixDaysAgo = subDays(new Date(), 6);
        await Promise.all(governmentContributions.map(contribution =>
            db.deductions.create({
                data: {
                    userId: employee.id,
                    deductionType: contribution.type,
                    amount: contribution.amount,
                    description: `${contribution.type} contribution`,
                    createdAt: sixDaysAgo,
                }
            })
        ));

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
            return { error: "Invalid net salary calculation." };
        }

        await db.$transaction(async (prisma) => {
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
                    daysLeave: leaveDaysCount
                }
            });

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

    const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
    await auditAction(user.id, `Employees added to Payroll by SuperAdmin: ${superAdminName}`);


    return { success: "Employee added to payroll successfully!" };
}

export async function addEmployeeToPayrollManual() {

}

export async function addMultipleEmployeesToPayrollCalculated() {

}