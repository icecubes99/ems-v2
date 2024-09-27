"use server"

import { DeductionsSchema } from "@/schemas/payroll-index";
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";
import { UserRole } from "@prisma/client";

export const updateDeductionsToUser = async (values: z.infer<typeof DeductionsSchema>, deductionId: string) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = DeductionsSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    const dbUser = await getUserById(user?.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const { userId, amount, deductionType, description } = validatedFields.data;

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Deduction Updated by Admin: ${adminName}`);

    await db.deductions.update({
        where: { id: deductionId },
        data: {
            userId,
            amount,
            deductionType,
            description,
        }
    });

    return { success: "Deduction Added!" };
}