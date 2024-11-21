
"use server"

import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { superAdmin } from "../superAdmin";
import { auditAction } from "@/actions/auditAction";
import { archiveEntity } from "./archive-entity";
import bcrypt from "bcryptjs";
import { ArchiveType, UserRole } from "@prisma/client";
import { db } from "@/lib/db";
import { ArchivedPassword } from "@/lib/constants/password";

export async function archiveUser(userId: string) {
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

        const targetUser = await db.user.findUnique({
            where: { id: userId }
        });

        if (!targetUser) {
            return { error: "User not found!" }
        }

        const newPassword = ArchivedPassword
        const hashedPassword = await bcrypt.hash(newPassword, 10);

        await db.user.update({
            where: { id: userId },
            data: {
                role: UserRole.USER,
                password: hashedPassword,
                isArchived: true
            }
        });

        await archiveEntity(ArchiveType.USER, userId, targetUser);
        await auditAction(user.id, `Archived user ${targetUser.firstName} ${targetUser.lastName}`);
        return { success: "User Archived!" }

    } catch (error) {
        console.log("Error in Archiving User", error)
        return { error: "Error Archiving User" }
    }
}