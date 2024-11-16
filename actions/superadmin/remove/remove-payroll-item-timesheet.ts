'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "@/actions/auditAction";
import { getUserById } from '@/data/user';
import { superAdmin } from "../superAdmin";
import { startOfDay, endOfDay, differenceInMinutes } from "date-fns";
import { calculateGovernmentContributions } from "../generate-payroll";
import { Status } from "@prisma/client";

export async function removeTimesheetFromPayroll(timesheetId: string) {
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

    // Step 4: Start a transaction
    return await db.$transaction(async (prisma) => {
        // Step 5: Get the timesheet and related payroll item
        const timesheet = await prisma.timesheet.findUnique({
            where: { id: timesheetId },
            include: {
                day: true, payrollItem: {
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

        const payrollItemId = timesheet.payrollItemId;
        const payrollItem = timesheet.payrollItem;
        const payroll = payrollItem.payroll;

        // Step 6: Remove the timesheet from the payroll item
        await prisma.timesheet.update({
            where: { id: timesheetId },
            data: { payrollItemId: null }
        });

        // Step 7: Recalculate payroll item values
        const updatedTimesheets = await prisma.timesheet.findMany({
            where: { payrollItemId },
            include: { day: true }
        });

        let totalMinutesWorked = 0;
        let totalLateMinutes = 0;
        let totalEarlyOutMinutes = 0;
        let overtimeMinutes = 0;
        let daysWorked = updatedTimesheets.length;
        let specialDayMinutes = 0;
        let specialDayEarnings = 0;

        const dailyRate = payrollItem.dailyRate;
        const minuteRate = dailyRate / 600; // Assuming 10 working hours per day

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
                    gte: payroll.payPeriodStart,
                    lte: payroll.payPeriodEnd
                }
            }
        });

        const totalWorkingDays = workingDays.length;
        const daysNotWorked = totalWorkingDays - daysWorked;
        const minutesNotWorked = (daysNotWorked * 600) + totalLateMinutes + totalEarlyOutMinutes;

        const basicSalary = daysWorked * dailyRate;
        const overtimeSalary = overtimeMinutes * minuteRate * 1.5;

        const lateDeduction = totalLateMinutes * minuteRate;
        const earlyOutDeduction = totalEarlyOutMinutes * minuteRate;
        const absentDeduction = (daysNotWorked * 600) * minuteRate;

        // Step 8: Recalculate government contributions
        const governmentContributions = await calculateGovernmentContributions(payrollItem.basicSalary);
        const totalGovernmentDeductions = governmentContributions.reduce((sum, contrib) => sum + contrib.amount, 0);

        // Step 9: Update the PayrollItem
        const updatedPayrollItem = await prisma.payrollItem.update({
            where: { id: payrollItemId },
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
                netSalary: (timesheet.user.userSalary?.grossSalary || basicSalary) - (lateDeduction + earlyOutDeduction + absentDeduction + totalGovernmentDeductions),
            }
        });

        // Step 10: Update the Payroll total amount
        await prisma.payroll.update({
            where: { id: payroll.id },
            data: {
                totalAmount: {
                    decrement: payrollItem.netSalary - updatedPayrollItem.netSalary
                }
            }
        });

        // Step 11: Update DaysNotWorked
        await prisma.daysNotWorked.deleteMany({
            where: { payrollItemId: payrollItemId }
        });

        const daysNotWorkedEntries = [];

        for (const workingDay of workingDays) {
            const hasTimesheet = updatedTimesheets.some(ts => ts.day.date.getTime() === workingDay.date.getTime());
            if (!hasTimesheet) {
                daysNotWorkedEntries.push({
                    date: workingDay.date,
                    userId: payrollItem.userId,
                    payrollItemId: payrollItem.id,
                });
            }
        }

        await prisma.daysNotWorked.createMany({
            data: daysNotWorkedEntries
        });

        // Step 12: Audit the action
        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(user.id, `Timesheet removed from Payroll by SuperAdmin: ${superAdminName}`);

        return { success: "Timesheet removed and payroll recalculated successfully!" };
    });
}