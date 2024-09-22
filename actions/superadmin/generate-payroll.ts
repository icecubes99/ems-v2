'use server'

import { prisma } from '@/lib/prisma'
import { currentUser } from "@/lib/auth"
import { auditAction } from "../auditAction"
import { startOfDay, endOfDay, subMonths, setDate, differenceInMinutes } from "date-fns"
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

        // Fetch working days for the pay period
        const workingDays = await prisma.workingDay.findMany({
            where: {
                date: {
                    gte: payPeriodStart,
                    lte: payPeriodEnd
                }
            }
        });

        const totalWorkingDays = workingDays.length;

        // Get all active employees
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
                }
            }
        });

        let totalPayrollAmount = 0;

        for (const employee of employees) {
            const { userSalary, timesheets, additionalEarnings, deductions } = employee;
            if (!userSalary) {
                console.error(`Employee ${employee.id} has no salary information.`);
                continue;
            }

            const dailyRate = userSalary.basicSalary / totalWorkingDays;
            const minuteRate = dailyRate / 600; // Assuming 10 working hours per day
            let totalMinutesWorked = 0;
            let totalLateMinutes = 0;
            let totalEarlyOutMinutes = 0;
            let overtimeMinutes = 0;
            let daysWorked = 0;

            for (const timesheet of timesheets) {
                if (!timesheet.clockOut) {
                    console.warn(`Timesheet ${timesheet.id} for employee ${employee.id} has no clock out time.`);
                    continue;
                }

                const clockIn = new Date(timesheet.clockIn);
                const clockOut = new Date(timesheet.clockOut);

                let dailyMinutes = Math.min(600, Math.max(0, differenceInMinutes(clockOut, clockIn)));
                totalMinutesWorked += dailyMinutes;

                // Use the existing clockOutEarlyMinutes and minutesLate fields
                totalEarlyOutMinutes += timesheet.clockOutEarlyMinutes;
                totalLateMinutes += timesheet.minutesLate;

                // Calculate overtime
                if (timesheet.isOvertime) {
                    overtimeMinutes += 60; // Add 60 minutes for each day marked as overtime
                }

                daysWorked++;
            }

            const daysNotWorked = totalWorkingDays - daysWorked;
            const minutesNotWorked = (daysNotWorked * 600) + totalLateMinutes + totalEarlyOutMinutes;

            const basicSalary = daysWorked * dailyRate;
            const overtimeSalary = overtimeMinutes * minuteRate * 1.5; // 1.5x rate for overtime
            const notWorkedDeduction = minutesNotWorked * minuteRate;

            // Calculate additional earnings
            const totalAdditionalEarnings = additionalEarnings.reduce((sum, earning) => sum + earning.amount, 0);

            // Calculate total deductions
            const totalDeductions = deductions.reduce((sum, deduction) => sum + deduction.amount, 0) + notWorkedDeduction;

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

            await prisma.payrollItem.create({
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