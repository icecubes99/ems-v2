"use server"

import { db } from "@/lib/db"

import { getUserById } from "@/data/user"
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";

export const deleteAdditionalEarningsOfUser = async (additionalEarningsId: string) => {
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

    await auditAction(dbUser.id, `Additional Earnings Deleted by Admin: ${adminName}`);

    await db.additionalEarnings.delete({
        where: { id: additionalEarningsId }
    });

    return { success: "Additional Earnings Deleted!" };
}

export const deleteMultipleAdditionalEarningsOfUser = async (additionalEarningsId: string[]) => {
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

    await auditAction(dbUser.id, `Multiple Additional Earnings Deleted by Admin: ${adminName}`);

    await db.$transaction(async (tx) => {
        for (const additionalEarningId of additionalEarningsId) {
            await tx.additionalEarnings.delete({
                where: { id: additionalEarningId }
            });
        }
    });

    return { success: "Additional Earnings Deleted!" };
}