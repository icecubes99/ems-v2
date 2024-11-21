"use server"

import { OvertimeSchema } from "@/schemas/attendance-index"
import { db } from "@/lib/db"
import * as z from "zod";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { Prisma } from "@prisma/client";
import { checkIsArchived } from "./checkIsArchived";

export const requestOvertime = async (values: z.infer<typeof OvertimeSchema>) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const isArchived = await checkIsArchived(user.id);
    if (isArchived.error) {
        return { error: isArchived.error };
    }

    const validatedFields = OvertimeSchema.safeParse(values);
    if (!validatedFields.success) {
        console.error("Validation error:", validatedFields.error);
        return { error: "Invalid fields!", details: validatedFields.error.errors };
    }

    const { reason, overtimeType, timeOut } = validatedFields.data;
    if (!reason || !overtimeType || !timeOut) {
        return { error: "Please fill in all fields!" }
    }

    const dbUser = await getUserById(user.id);

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    // Check if the user already has an overtime entry for today
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Set to the start of the day

    const existingOvertime = await db.overtimes.findFirst({
        where: {
            userId: user.id,
            createdAt: {
                gte: today,
                lt: new Date(today.getTime() + 24 * 60 * 60 * 1000) // End of the day
            }
        }
    });

    if (existingOvertime) {
        return { error: "Overtime already requested for today!" };
    }

    // Fetch the timesheet for today
    const timesheet = await db.timesheet.findFirst({
        where: {
            userId: user.id,
            clockIn: {
                gte: today,
                lt: new Date(today.getTime() + 24 * 60 * 60 * 1000) // End of the day
            }
        }
    });

    if (!timesheet) {
        return { error: "No timesheet found for today. Please ensure you have clocked in." };
    }

    try {
        const [hours, minutes] = timeOut.split(':').map(Number);
        const timeOutDate = new Date();
        timeOutDate.setHours(hours, minutes, 0, 0);

        const overtime = await db.overtimes.create({
            data: {
                reason,
                overtimeType,
                userId: dbUser.id,
                timeOut: timeOutDate,
                clockIn: new Date(),
                status: 'IN_PROGRESS'
            }
        });

        await auditAction(dbUser.id, "User started Overtime")
        return { success: "Overtime started", overtimeId: overtime.id };
    } catch (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            if (error.code === "P2002") {
                return { error: "Overtime request already exists for today" }
            }
        }
        console.error("Error submitting overtime request:", error);
        return { error: "Error submitting overtime request" };
    }
}

export const clockOutOvertime = async () => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    try {
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        const overtime = await db.overtimes.findFirst({
            where: {
                userId: user.id,
                status: 'IN_PROGRESS',
                createdAt: {
                    gte: today,
                    lt: new Date(today.getTime() + 24 * 60 * 60 * 1000)
                }
            }
        });

        if (!overtime) {
            return { error: "No active overtime found for today" };
        }

        await db.overtimes.update({
            where: { id: overtime.id },
            data: {
                clockOut: new Date(),
                status: 'PENDING'
            }
        });

        await auditAction(user.id, "User ended Overtime")
        return { success: "Overtime ended successfully" };
    } catch (error) {
        console.error("Error ending overtime:", error);
        return { error: "Error ending overtime" };
    }
}