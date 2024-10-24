"use server"

import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { PendingOvertimesSchema } from "@/schemas/attendance-index";
import { admin } from "../admin";
import { LeaveStatus, UserRole, OvertimeType, OvertimeStatus } from "@prisma/client";
import { startOfDay, endOfDay, differenceInMinutes, setHours, setMinutes } from "date-fns";

export const approveDenyOvertimes = async (overtimeId: string, action: z.infer<typeof PendingOvertimesSchema>) => {
    const user = await currentUser();
    const validatedFields = PendingOvertimesSchema.safeParse(action);

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user.id);

    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    if (!dbUser) {
        return { error: "User not found in database" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const overtime = await db.overtimes.findUnique({
        where: { id: overtimeId },
        include: { user: true }
    });

    if (!overtime || !overtime.clockOut) {
        return { error: "Overtime not Found!" }
    }

    const overtimeClockOut = new Date(overtime.clockOut);
    const sixPM = setMinutes(setHours(new Date(overtimeClockOut), 18), 0);
    const minutesFromSixPM = differenceInMinutes(overtimeClockOut, sixPM);


    const { status } = validatedFields.data;

    if (status === LeaveStatus.APPROVED) {
        // Find the timesheet for the day of the overtime
        const timesheet = await db.timesheet.findFirst({
            where: {
                userId: overtime.userId,
                day: {
                    date: {
                        gte: startOfDay(overtime.createdAt),
                        lte: endOfDay(overtime.createdAt),
                    },
                },
            },
        });

        if (timesheet) {
            // Update the overtime status
            await db.overtimes.update({
                where: { id: overtimeId },
                data: {
                    status: OvertimeStatus.COMPLETED
                }
            });

            // Update the timesheet
            await db.timesheet.update({
                where: { id: timesheet.id },
                data: {
                    isOvertime: true,
                    clockOut: overtime.clockOut,
                    minutesOvertime: minutesFromSixPM,
                },
            });

            await auditAction(dbUser.id, `Overtime Approved by ${user.role}: ${user.name}`)
            return { success: "Overtime Request Approved" };
        } else {
            // If no timesheet is found, don't approve the overtime
            return { error: "Cannot approve overtime: No timesheet found for the overtime date" };
        }
    } else if (status === LeaveStatus.REJECTED) {
        await db.overtimes.update({
            where: { id: overtimeId },
            data: { status: LeaveStatus.REJECTED }
        });

        await auditAction(dbUser.id, `Overtime Rejected by ${user.role}: ${user.name}`)
        return { success: "Overtime Request Rejected" };
    }

    return { error: "Invalid action" };
}