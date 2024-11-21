"use server"

import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db"
import { superAdmin } from "../superAdmin";
import { auditAction } from "@/actions/auditAction";
import { archiveEntity } from "./archive-entity";
import { ArchiveType } from "@prisma/client";

export async function removeAllowance(allowanceId: string) {
    try {
        const user = await currentUser();
        if (!user) {
            return { error: "Unauthorized!" };
        }

        const dbUser = await getUserById(user.id);
        if (!dbUser) {
            return { error: "User not found in database!" }
        }

        const superadminResult = await superAdmin();
        if (superadminResult.error) {
            return { error: superadminResult.error }
        }

        const allowance = await db.allowance.findFirst({
            where: {
                id: allowanceId
            }
        })

        if (!allowance) {
            return { error: "Allowance not found!" }
        }

        await (ArchiveType.ALLOWANCE, allowanceId, allowance);

        await db.allowance.delete({
            where: {
                id: allowanceId
            }
        })

        const superAdminName = user?.name || `${dbUser.firstName} ${dbUser.lastName}`
        await auditAction(dbUser.id, `Removed allowance by: ${superAdminName}`);

        return { success: "Allowance Removed!" }

    } catch (error) {
        return { error: "Error Removing Allowance from Employee" }
    }
}