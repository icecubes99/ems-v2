
"use server"

import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { superAdmin } from "../superAdmin";
import { auditAction } from "@/actions/auditAction";
import { archiveEntity } from "./archive-entity";
import { ArchiveType } from "@prisma/client";
import { db } from "@/lib/db";

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

    } catch (error) {
        console.log("Error in Archiving User", error)
        return { error: "Error Archiving User" }
    }
}