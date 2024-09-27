"use server"

import { db } from "@/lib/db"

import { getUserById } from "@/data/user"
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";

export const deleteDeductionsOfUser = async (deductionsId: string) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user?.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Deductions Deleted by Admin: ${adminName}`);

    await db.deductions.delete({
        where: { id: deductionsId }
    });

    return { success: "Deductions Deleted!" };
}