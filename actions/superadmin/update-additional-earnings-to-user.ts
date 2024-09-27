"use server"

import { AdditionalEarningsSchema } from "@/schemas/payroll-index";
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";

export const updateAdditionalEarningsToUser = async (values: z.infer<typeof AdditionalEarningsSchema>, additionalEarningsId: string) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = AdditionalEarningsSchema.safeParse(values);
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

    const { userId, amount, earningType, description } = validatedFields.data;

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Additional Earnings Updated by Admin: ${adminName}`);

    await db.additionalEarnings.update({
        where: { id: additionalEarningsId },
        data: {
            userId,
            amount,
            earningType,
            description,
        }
    });

    return { success: "Additional Earnings Updated!" };
}