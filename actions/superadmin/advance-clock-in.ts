"use server"

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { z } from "zod";
import { superAdmin } from "./superAdmin";
import { AdvanceClockInSchema } from "@/schemas/attendance-index";
import { Prisma } from '@prisma/client';

export async function advanceClockIn(values: z.infer<typeof AdvanceClockInSchema>) {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized: User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: `Unauthorized: ${superAdminResult.error}` };
    }

    const validatedFields = AdvanceClockInSchema.safeParse(values);

    if (!validatedFields.success) {
        return { error: "Invalid input: " + validatedFields.error.message };
    }

    const { endDate, startDate, userIds, type } = validatedFields.data;

    try {
        const startD = new Date(startDate);
        const endD = new Date(endDate);

        if (startD > endD) {
            return { error: "Invalid date range: Start date must be before or equal to end date" };
        }

        const result = await db.$transaction(async (tx) => {
            const advanceTimesheet = await tx.advanceTimesheet.create({
                data: {
                    startDate: startD,
                    endDate: endD,
                    type,
                    users: {
                        create: userIds.map(userId => ({
                            user: { connect: { id: userId } }
                        }))
                    }
                }
            });

            for (const userId of userIds) {
                for (let date = new Date(startD); date <= endD; date.setDate(date.getDate() + 1)) {
                    const workingDay = await tx.workingDay.findFirst({
                        where: {
                            date: {
                                gte: new Date(date.getFullYear(), date.getMonth(), date.getDate()),
                                lt: new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1),
                            },
                        },
                    });

                    if (!workingDay) {
                        console.warn(`No working day found for date: ${date.toISOString()}`);
                        continue;
                    }

                    const existingTimesheets = await tx.timesheet.findMany({
                        where: {
                            userId,
                            dayId: workingDay.id
                        }
                    });

                    if (existingTimesheets.length > 0) {
                        console.warn(`Existing timesheets found for user ${userId} on ${date.toISOString()}`);
                    }

                    const clockInTime = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 8, 0, 0);
                    const clockOutTime = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 18, 0, 0);

                    await tx.timesheet.create({
                        data: {
                            userId: userId,
                            dayId: workingDay.id,
                            clockIn: clockInTime,
                            clockOut: clockOutTime,
                            isLate: false,
                            minutesLate: 0,
                            isAdvanced: true,
                        },
                    });
                }
            }

            return advanceTimesheet;
        });

        await auditAction(user.id, `Advanced Timesheet generation for multiple users by SuperAdmin: ${user.name}`);

        return {
            success: `Successfully created advanced timesheets for users`,
            data: result
        };
    } catch (error) {
        console.error("Error creating advanced clock ins", error);
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            // Handle specific Prisma errors
            if (error.code === 'P2002') {
                return { error: "A timesheet has already been made for this user" };
            }
        }
        return { error: "An error occurred while processing the advance clockins" };
    }
}