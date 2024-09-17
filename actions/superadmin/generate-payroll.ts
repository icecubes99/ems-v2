// actions/superadmin/generate-payroll.ts

'use server'

import { prisma } from '@/lib/prisma'
import { currentUser } from "@/lib/auth"
import { auditAction } from "../auditAction"
import { startOfDay, endOfDay, subMonths, setDate, addMinutes, differenceInMinutes } from "date-fns"
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

        // Determine the pay period based on the current date
        if (today.getDate() >= 11 && today.getDate() <= 15) {
            payPeriodStart = startOfDay(setDate(subMonths(today, 1), 26));
            payPeriodEnd = endOfDay(setDate(today, 10));
        } else if (today.getDate() >= 26 && today.getDate() <= 31) {
            payPeriodStart = startOfDay(setDate(today, 11));
            payPeriodEnd = endOfDay(setDate(today, 25));
        } else {
            return { error: "Payroll can only be generated between the 11th-15th or 26th-31st of the month." };
        }

        // Check if Prisma client is initialized
        if (!prisma) {
            throw new Error('Prisma client is not initialized');
        }

        // Check if Payroll model exists
        if (!prisma.payroll) {
            throw new Error('Payroll model is not defined in Prisma schema');
        }

        // Check if a payroll already exists for this period
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

        // Get all active employees
        const employees = await prisma.user.findMany({
            where: {
                role: {
                    not: "SUPERADMIN"
                },
                userSalary: {
                    isNot: null
                }
            },
            include: {
                assignedDesignations: true,
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
                }
            }
        });

        let totalPayrollAmount = 0;

        for (const employee of employees) {
            const { userSalary, timesheets, additionalEarnings, deductions } = employee;
            if (!userSalary) continue;

            let totalMinutesWorked = 0;
            let daysWorked = 0;
            let overtimeHours = 0;

            for (const timesheet of timesheets) {
                if (!timesheet.clockOut) continue;

                const clockIn = new Date(timesheet.clockIn);
                const clockOut = new Date(timesheet.clockOut);

                // Calculate regular hours
                const expectedClockIn = new Date(clockIn.setHours(8, 0, 0, 0));
                const expectedClockOut = new Date(clockIn.setHours(17, 0, 0, 0));

                let dailyMinutes = 0;

                const clockInGracePeriod = addMinutes(expectedClockIn, 15);
                const clockOutGracePeriod = addMinutes(expectedClockOut, -15);

                if (clockIn <= clockInGracePeriod && clockOut >= clockOutGracePeriod) {
                    // Full day
                    dailyMinutes = 9 * 60; // 9 hours in minutes
                } else {
                    // Calculate actual minutes worked
                    dailyMinutes = Math.max(0, Math.min(540, differenceInMinutes(clockOut, clockIn)));
                }

                totalMinutesWorked += dailyMinutes;
                daysWorked++;

                // Calculate overtime
                if (clockOut.getHours() >= 18) {
                    overtimeHours += 1;
                }
            }

            const basicSalary = (totalMinutesWorked / (9 * 60 * daysWorked)) * userSalary.basicSalary;
            const overtimeSalary = overtimeHours * (userSalary.hourlyRate || 0);

            // Calculate additional earnings
            const totalAdditionalEarnings = additionalEarnings.reduce((sum, earning) => sum + earning.amount, 0);

            // Calculate total deductions
            const totalDeductions = deductions.reduce((sum, deduction) => sum + deduction.amount, 0);

            const netSalary = basicSalary + overtimeSalary + totalAdditionalEarnings - totalDeductions;

            await prisma.payrollItem.create({
                data: {
                    payrollId: newPayroll.id,
                    userId: employee.id,
                    basicSalary,
                    overtimeSalary,
                    additionalEarnings: totalAdditionalEarnings,
                    totalDeductions,
                    netSalary,
                    daysWorked,
                    minutesWorked: totalMinutesWorked
                }
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

// todo
// payrollItem not working fix
// 