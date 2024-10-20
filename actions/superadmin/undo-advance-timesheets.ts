"use server"

import { db } from "@/lib/db"
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { superAdmin } from "./superAdmin";

export async function undoAdvanceTimesheets(advanceTimesheetsId: string) {
    const user = await currentUser();

    if (!user) {
        return { error: "User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    try {
        await db.$transaction(async (tx) => {
            const advanceTimesheets = await tx.advanceTimesheet.findUnique({
                where: { id: advanceTimesheetsId },
                include: {
                    users: true
                }
            });

            if (!advanceTimesheets) {
                return { error: "Advance timesheets not found" };
            }

            const startDate = advanceTimesheets.startDate;
            const endDate = advanceTimesheets.endDate;
            const userIds = advanceTimesheets.users.map(user => user.userId);

            for (const userId of userIds) {
                for (let date = new Date(startDate); date <= endDate; date.setDate(date.getDate() + 1)) {
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

                    await tx.timesheet.deleteMany({
                        where: {
                            dayId: workingDay.id
                        }
                    })
                }
            }

            await tx.advanceTimesheet.update({
                where: { id: advanceTimesheetsId },
                data: {
                    isUndone: true
                }
            });
            await auditAction(user.id, `Undid Advanced Timesheet generation for multiple users by SuperAdmin: ${user.name}`);

        });

        return { success: "Advance timesheets undone successfully", };
    } catch (error) {
        console.error(error);
        return { error: "Something went wrong" };
    }
}