'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "@/actions/auditAction";
import { differenceInMinutes } from "date-fns";
import { calculateGovernmentContributions } from "./generate-payroll";
import { getUserById } from "@/data/user";
import { superAdmin } from "./superAdmin";
import { Status } from "@prisma/client";
import { EditPayrollItemTimesheetSchema } from "@/schemas/payroll-index";
import * as z from "zod";

export async function editTimesheetInPayroll(timesheetId: string, values: z.infer<typeof EditPayrollItemTimesheetSchema>) {
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

    const validatedFields = EditPayrollItemTimesheetSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid Fields!" }
    }

    const { isLate, minutesLate, isOvertime, minutesOvertime } = validatedFields.data;

    try {
        await db.$transaction(async (prisma) => {
            const timesheet = await prisma.timesheet.findUnique({
                where: { id: timesheetId },
                include: {
                    payrollItem: {
                        include: { payroll: true },
                    },
                    user: {
                        include: { userSalary: true }
                    }
                }
            });

            if (!timesheet || !timesheet.payrollItem || !timesheet.payrollItemId) {
                return { error: "Timesheet or PayrollItem not found!" };
            }

            if (timesheet.clockIn && timesheet.clockOut) {
                const updatedClockIn = isLate
                    ? new Date(new Date(timesheet.clockIn).getTime() + minutesLate * 60000)
                    : timesheet.clockIn;

                const updatedClockOut = isOvertime
                    ? new Date(new Date(timesheet.clockOut).getTime() + minutesOvertime * 60000)
                    : timesheet.clockOut;

                await prisma.timesheet.update({
                    where: { id: timesheetId },
                    data: {
                        isLate,
                        minutesLate,
                        isOvertime,
                        minutesOvertime,
                        clockIn: updatedClockIn,
                        clockOut: updatedClockOut,
                    },
                });
            } else {
                return { error: "Clock-in or Clock-out time is missing!" };
            }
            // Recalculate Payroll Item
            // (Reusing logic from removeTimesheetFromPayroll)
            // Fetch updated timesheets
            const updatedTimesheets = await prisma.timesheet.findMany({
                where: { payrollItemId: timesheet.payrollItemId },
                include: { day: true }
            });

            let totalMinutesWorked = 0;
            let totalLateMinutes = 0;
            let totalEarlyOutMinutes = 0;
            let overtimeMinutes = 0;
            let daysWorked = updatedTimesheets.length;
            let specialDayMinutes = 0;
            let specialDayEarnings = 0;

            const dailyRate = timesheet.payrollItem.dailyRate;
            const minuteRate = dailyRate / 600;

            for (const ts of updatedTimesheets) {
                if (!ts.clockOut) continue;

                const clockIn = new Date(ts.clockIn);
                const clockOut = new Date(ts.clockOut);

                let dailyMinutes = Math.min(600, Math.max(0, differenceInMinutes(clockOut, clockIn)));
                totalMinutesWorked += dailyMinutes;

                totalEarlyOutMinutes += ts.clockOutEarlyMinutes;
                totalLateMinutes += ts.minutesLate;

                if (ts.isOvertime) {
                    overtimeMinutes += ts.minutesOvertime;
                }

                if (!ts.day.isRequired) {
                    specialDayMinutes += dailyMinutes;
                    specialDayEarnings += dailyMinutes * minuteRate * 2;
                    if (ts.isOvertime) {
                        specialDayEarnings += ts.minutesOvertime * minuteRate * 2.5;
                    }
                }
            }

            const workingDays = await prisma.workingDay.findMany({
                where: {
                    date: {
                        gte: timesheet.payrollItem.payroll.payPeriodStart,
                        lte: timesheet.payrollItem.payroll.payPeriodEnd
                    }
                }
            });

            const payrollItem = await prisma.payrollItem.findUnique({
                where: { id: timesheet.payrollItemId }
            })

            if (!payrollItem) {
                return { error: "Payroll Item not found!" };
            }

            const totalWorkingDays = workingDays.length;
            const daysNotWorked = totalWorkingDays - daysWorked;
            const minutesNotWorked = (daysNotWorked * 600) + totalLateMinutes + totalEarlyOutMinutes;

            const basicSalary = daysWorked * dailyRate;
            const overtimeSalary = overtimeMinutes * minuteRate * 1.5;

            const lateDeduction = totalLateMinutes * minuteRate;
            const earlyOutDeduction = totalEarlyOutMinutes * minuteRate;
            const absentDeduction = (daysNotWorked * 600) * minuteRate;

            const governmentContributions = await calculateGovernmentContributions(timesheet.payrollItem.basicSalary);
            const totalGovernmentDeductions = governmentContributions.reduce((sum, contrib) => sum + contrib.amount, 0);

            let updatedNetSalary = ((timesheet.user.userSalary?.grossSalary || basicSalary) + payrollItem.additionalEarnings + overtimeSalary + specialDayEarnings) - (lateDeduction + earlyOutDeduction + absentDeduction + totalGovernmentDeductions)

            const updatedPayrollItem = await prisma.payrollItem.update({
                where: { id: timesheet.payrollItemId },
                data: {
                    daysWorked,
                    daysNotWorked,
                    minutesWorked: totalMinutesWorked,
                    minutesNotWorked,
                    minutesLate: totalLateMinutes,
                    minutesOvertime: overtimeMinutes,
                    minutesEarlyOut: totalEarlyOutMinutes,
                    overtimeSalary,
                    lateDeductions: lateDeduction,
                    earlyClockOutDeductions: earlyOutDeduction,
                    specialDayMinutes,
                    specialDayEarnings,
                    totalDeductions: lateDeduction + earlyOutDeduction + absentDeduction + totalGovernmentDeductions,
                    netSalary: updatedNetSalary
                }
            });

            await prisma.payroll.update({
                where: { id: timesheet.payrollItem.payroll.id },
                data: {
                    totalAmount: {
                        decrement: timesheet.payrollItem.netSalary - updatedPayrollItem.netSalary
                    }
                }
            });

            // Audit the action
            const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
            await auditAction(user.id, `Timesheet edited in Payroll by SuperAdmin: ${superAdminName}`);
        });

        return { success: "Timesheet updated and payroll recalculated successfully!" };
    } catch (error) {
        console.error("Error updating the timesheet:", error)
        return { error: "An error occurred while updating the timesheet and recalculating the payroll." };
    }
}
