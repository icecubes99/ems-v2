"use server"

import { OvertimeSchema } from "@/schemas/attendance-index"
import { db } from "@/lib/db"
import * as z from "zod";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { Prisma } from "@prisma/client";

export const requestOvertime = async (values: z.infer<typeof OvertimeSchema>) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = OvertimeSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    const { reason, overtimeType } = validatedFields.data;
    if (!reason || !overtimeType) {
        return { error: "Please fill in all fields!" }
    }

    // Fetch user
    const dbUser = await db.user.findUnique({
        where: { id: user.id },
    });

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    // Check if the user already has an overtime entry for the current day
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

    try {
        await db.overtimes.create({
            data: {
                reason,
                overtimeType,
                userId: dbUser.id
            }
        });

        await auditAction(dbUser.id, "User requested Overtime")
        return { success: "Overtime request submitted" };
    } catch (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            if (error.code === "P2002") {
                return { error: "Overtime request already exists for this day" }
            }
        }
        console.error("Error submitting overtime request:", error);
        return { error: "Error submitting overtime request" };
    }

}
