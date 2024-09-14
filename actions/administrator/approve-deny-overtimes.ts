"use server"

import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { PendingOvertimesSchema } from "@/schemas/attendance-index";
import { admin } from "../admin";
import { LeaveStatus, UserRole, OvertimeType } from "@prisma/client";

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

    if (!overtime) {
        return { error: "Overtime not Found!" }
    }

    const { status } = validatedFields.data;

    if (status === LeaveStatus.APPROVED) {
        // Update the overtime status
        await db.overtimes.update({
            where: { id: overtimeId },
            data: { status: LeaveStatus.APPROVED }
        });

        // Find the timesheet for the day of the overtime
        const timesheet = await db.timesheet.findFirst({
            where: {
                userId: overtime.userId,
                createdAt: {
                    gte: new Date(overtime.createdAt.getFullYear(), overtime.createdAt.getMonth(), overtime.createdAt.getDate()),
                    lt: new Date(overtime.createdAt.getFullYear(), overtime.createdAt.getMonth(), overtime.createdAt.getDate() + 1),
                },
            },
        });

        if (timesheet) {
            // Update the timesheet's clock out time to 6:00 PM
            const clockOutTime = new Date(timesheet.createdAt);
            clockOutTime.setHours(19, 0, 0, 0); // Set to 7:00 PM

            await db.timesheet.update({
                where: { id: timesheet.id },
                data: { clockOut: clockOutTime },
            });
        } else {
            return { error: "Timesheet not found for the overtime date" };
        }
    } else if (status === LeaveStatus.REJECTED) {
        await db.overtimes.update({
            where: { id: overtimeId },
            data: { status: LeaveStatus.REJECTED }
        });
    }

    await auditAction(dbUser.id, `Overtime ${status} by ${user.role}: ${user.name}`)
    return { success: `Overtime Request ${status}` };
}