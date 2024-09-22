"use server"

import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { TimesheetSchema } from '@/schemas/attendance-index';
import { differenceInMinutes, setHours, setMinutes } from "date-fns";

export const logTimesheet = async (values: z.infer<typeof TimesheetSchema> & { isClockingIn: boolean }) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user?.id);

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    // Find the current working day
    const today = new Date();
    const workingDay = await db.workingDay.findFirst({
        where: {
            date: {
                gte: new Date(today.getFullYear(), today.getMonth(), today.getDate()),
                lt: new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1),
            },
        },
    });

    if (!workingDay) {
        return { error: "No working day found for today!" };
    }

    if (values.isClockingIn) {
        // Check if user has already logged in today
        const existingTimesheet = await db.timesheet.findUnique({
            where: {
                userId_dayId: {
                    userId: dbUser.id,
                    dayId: workingDay.id,
                },
            },
        });

        if (existingTimesheet) {
            return { error: "You have already clocked in for today!" };
        }

        if (workingDay.password !== values.password) {
            return { error: "Incorrect password!" };
        }

        // Calculate clock in time
        const clockInTime = new Date();
        let adjustedClockInTime = new Date(clockInTime);
        adjustedClockInTime.setHours(8, 0, 0, 0); // Set to 8:00 AM

        const cutoffTime = new Date(clockInTime.getFullYear(), clockInTime.getMonth(), clockInTime.getDate(), 8, 15, 0); // 8:15 AM
        const isLate = clockInTime > cutoffTime;
        const minutesLate = isLate ? Math.floor((clockInTime.getTime() - cutoffTime.getTime()) / 60000) : 0;

        // Check previous timesheet
        const previousTimesheet = await db.timesheet.findFirst({
            where: {
                userId: dbUser.id,
                dayId: { lt: workingDay.id },
            },
            orderBy: { dayId: 'desc' },
        });

        if (previousTimesheet && !previousTimesheet.clockOut) {
            // Set previous timesheet's clockOut to 12:00 PM of its day
            const previousClockOutTime = new Date(previousTimesheet.clockIn);
            previousClockOutTime.setHours(12, 0, 0, 0);

            const expectedClockOut = new Date(previousTimesheet.clockIn);
            expectedClockOut.setHours(18, 0, 0, 0);

            const clockOutEarlyMinutes = differenceInMinutes(expectedClockOut, previousClockOutTime);

            await db.timesheet.update({
                where: { id: previousTimesheet.id },
                data: {
                    clockOut: previousClockOutTime,
                    forgotClockOut: true,
                    clockOutEarly: true,
                    clockOutEarlyMinutes: clockOutEarlyMinutes
                },
            });
        }

        // Create new timesheet entry
        await db.timesheet.create({
            data: {
                userId: dbUser.id,
                dayId: workingDay.id,
                clockIn: adjustedClockInTime,
                isLate,
                minutesLate,
            },
        });

        await auditAction(dbUser.id, "User Timesheet Clock In");

        let successMessage = "Clock in time logged successfully!";
        if (isLate) {
            successMessage += ` You are ${minutesLate} minutes late.`;
        }

        return { success: successMessage };
    } else {
        // Clocking out
        const existingTimesheet = await db.timesheet.findUnique({
            where: {
                userId_dayId: {
                    userId: dbUser.id,
                    dayId: workingDay.id,
                },
            },
        });

        if (!existingTimesheet) {
            return { error: "You haven't clocked in yet today!" };
        }

        if (existingTimesheet.clockOut) {
            return { error: "You have already clocked out for today!" };
        }

        // Determine the clock out time
        let clockOutTime = new Date();
        const cutoffClockOutTime = new Date(clockOutTime.getFullYear(), clockOutTime.getMonth(), clockOutTime.getDate(), 17, 45, 0); // 5:45 PM
        const fixedClockOutTime = new Date(clockOutTime.getFullYear(), clockOutTime.getMonth(), clockOutTime.getDate(), 18, 0, 0); // 6:00 PM
        const expectedClockOut = setHours(setMinutes(new Date(clockOutTime), 0), 18); // 6:00 PM

        let clockOutEarly = false;
        let clockOutEarlyMinutes = 0;

        if (clockOutTime < expectedClockOut) {
            clockOutEarly = true;
            clockOutEarlyMinutes = differenceInMinutes(expectedClockOut, clockOutTime);
        } else if (clockOutTime >= cutoffClockOutTime) {
            clockOutTime = fixedClockOutTime;
        }

        // Update existing timesheet with clock out time
        await db.timesheet.update({
            where: { id: existingTimesheet.id },
            data: {
                clockOut: clockOutTime,
                clockOutEarly,
                clockOutEarlyMinutes
            },
        });

        await auditAction(dbUser.id, "User Timesheet Clock Out");

        let successMessage = "Clock out time logged successfully!";
        if (clockOutEarly) {
            successMessage += ` You clocked out ${clockOutEarlyMinutes} minutes early.`;
        }

        return { success: successMessage };
    }
};