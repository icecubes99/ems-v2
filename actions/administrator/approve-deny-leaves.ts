"use server"

import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { PendingLeavesSchema } from "@/schemas/attendance-index";
import { admin } from "../admin";
import { LeaveStatus, UserRole, LeaveType } from "@prisma/client";
import { PrismaClient, Prisma } from '@prisma/client';

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
        where: { id: leaveId },
        include: { user: true }
    });

    if (!leave) {
        return { error: "Leave not Found!" }
    }

    const { leaveStatus } = validatedFields.data;

    // Calculate the number of days for this leave
    const startDate = new Date(leave.startDate);
    const endDate = new Date(leave.endDate);
    const daysDifference = Math.ceil((endDate.getTime() - startDate.getTime()) / (1000 * 3600 * 24)) + 1;

    if (leaveStatus === LeaveStatus.APPROVED) {
        // Check if the user still has enough leave days
        if (leave.leaveType === LeaveType.VACATION || leave.leaveType === LeaveType.INCENTIVE) {
            const userWithLeaves = await db.user.findUnique({
                where: { id: leave.userId },
                include: {
                    leaves: {
                        where: {
                            leaveType: leave.leaveType,
                            leaveStatus: { not: LeaveStatus.REJECTED },
                            NOT: { id: leaveId }
                        }
                    }
                }
            });

            if (!userWithLeaves) {
                return { error: "User not found!" };
            }

            const usedDays = userWithLeaves.leaves.reduce((total, leave) =>
                total + Math.ceil((leave.endDate.getTime() - leave.startDate.getTime()) / (1000 * 3600 * 24)) + 1, 0
            );

            const availableDays = leave.leaveType === LeaveType.VACATION
                ? (userWithLeaves.vacationDays ?? 0)
                : (userWithLeaves.incentiveDays ?? 0);

            if (availableDays < daysDifference) {
                return { error: `Not enough ${leave.leaveType.toLowerCase()} days available for approval.` };
            }

            // Deduct the leave days
            await db.user.update({
                where: { id: leave.userId },
                data: {
                    [leave.leaveType === LeaveType.VACATION ? 'vacationDays' : 'incentiveDays']: {
                        decrement: daysDifference
                    }
                }
            });
        }

        await db.leaves.update({
            where: { id: leaveId },
            data: { leaveStatus: LeaveStatus.APPROVED }
        });

        // Create timesheets for each day of the approved leave
        for (let date = new Date(startDate); date <= endDate; date.setDate(date.getDate() + 1)) {
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

                // await db.timesheet.create({
                //     data: {
                //         userId: leave.userId,
                //         dayId: workingDay.id,
                //         clockIn: clockInTime,
                //         clockOut: clockOutTime,
                //         isLate: false,
                //         minutesLate: 0,
                //     },
                // });

                try {
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
                } catch (error) {
                    if (error instanceof Prisma.PrismaClientKnownRequestError) {
                        if (error.code === 'P2002') {
                            return { error: `A timesheet entry already exists for this user on ${date.toDateString()}. Cannot create duplicate entries.` };
                        }
                    }
                    throw error; // Re-throw if it's not a unique constraint error
                }
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