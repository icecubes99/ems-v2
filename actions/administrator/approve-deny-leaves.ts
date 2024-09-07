"use server"
import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { PendingLeavesSchema } from "@/schemas/attendance-index";
import { admin } from "../admin";
import { LeaveStatus, UserRole } from "@prisma/client";

export const approveDenyLeaves = async (leaveId: string, action: z.infer<typeof PendingLeavesSchema>) => {
    const user = await currentUser();
    const validatedFields = PendingLeavesSchema.safeParse(action);

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

    const leave = await db.leaves.findUnique({
        where: { id: leaveId }
    })

    if (!leave) {
        return { error: "Leave not Found!" }
    }

    const { leaveStatus } = validatedFields.data;

    if (leaveStatus === LeaveStatus.APPROVED) {
        await db.leaves.update({
            where: { id: leaveId },
            data: { leaveStatus: LeaveStatus.APPROVED }
        });

        // Create timesheets for each day of the approved leave
        const startDate = new Date(leave.startDate);
        const endDate = new Date(leave.endDate);

        for (let date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
            const workingDay = await db.workingDay.findFirst({
                where: {
                    date: {
                        gte: new Date(date.getFullYear(), date.getMonth(), date.getDate()),
                        lt: new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1),
                    },
                },
            });

            if (workingDay) {
                const clockInTime = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 8, 0, 0);
                const clockOutTime = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 17, 0, 0);

                await db.timesheet.create({
                    data: {
                        userId: leave.userId,
                        dayId: workingDay.id,
                        clockIn: clockInTime,
                        clockOut: clockOutTime,
                        isLate: false,
                        minutesLate: 0,
                    },
                });
            }
        }
    } else if (leaveStatus === LeaveStatus.REJECTED) {
        await db.leaves.update({
            where: { id: leaveId },
            data: { leaveStatus: LeaveStatus.REJECTED }
        });
    }

    await auditAction(dbUser.id, `Leave ${leaveStatus} by ${user.role}: ${user.name}`)
    return { success: `Leave Request ${leaveStatus}` };
}