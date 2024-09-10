// actions/log-timesheet.ts
"use server"

import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { TimesheetSchema } from '@/schemas/attendance-index';

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

    // Check if user has already logged in today
    const existingTimesheet = await db.timesheet.findUnique({
        where: {
            userId_dayId: {
                userId: dbUser.id,
                dayId: workingDay.id,
            },
        },
    });

    if (values.isClockingIn) {
        if (existingTimesheet) {
            return { error: "You have already clocked in for today!" };
        }

        if (workingDay.password !== values.password) {
            return { error: "Incorrect password!" };
        }

        // Calculate if the user is late
        const clockInTime = new Date();
        const cutoffTime = new Date(clockInTime.getFullYear(), clockInTime.getMonth(), clockInTime.getDate(), 8, 15, 0); // 8:15 AM
        const isLate = clockInTime > cutoffTime;
        const minutesLate = isLate ? Math.floor((clockInTime.getTime() - cutoffTime.getTime()) / 60000) : 0;

        // Create new timesheet entry
        await db.timesheet.create({
            data: {
                userId: dbUser.id,
                dayId: workingDay.id,
                clockIn: clockInTime,
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

        if (clockOutTime >= cutoffClockOutTime) {
            clockOutTime = fixedClockOutTime;
        }

        // Update existing timesheet with clock out time
        await db.timesheet.update({
            where: { id: existingTimesheet.id },
            data: { clockOut: clockOutTime },
        });

        await auditAction(dbUser.id, "User Timesheet Clock Out");
        return { success: "Clock out time logged successfully!" };
    }
};