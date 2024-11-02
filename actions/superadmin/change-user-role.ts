"use server"

import * as z from "zod";
import { UserRole } from "@prisma/client";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { superAdmin } from "./superAdmin";
import { ChangeUserRoleSchema } from "@/schemas/register-index";


export const changeUserRole = async (values: z.infer<typeof ChangeUserRoleSchema>) => {
    try {
        const user = await currentUser();
        if (!user) {
            return { error: "Unauthorized!" };
        }

        const dbUser = await getUserById(user.id);
        if (!dbUser) {
            return { error: "User not found in database!" }
        }

        const superAdminResult = await superAdmin();
        if (superAdminResult.error) {
            return { error: superAdminResult.error };
        }

        const validatedFields = ChangeUserRoleSchema.safeParse(values);
        if (!validatedFields.success) {
            return { error: "Invalid fields!" };
        }

        const { userId, role } = validatedFields.data;

        const targetUser = await getUserById(userId);
        if (!targetUser) {
            return { error: "Target user not found!" };
        }

        await db.user.update({
            where: { id: userId },
            data: { role }
        });

        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        const targetUserName = targetUser.firstName + " " + targetUser.lastName;
        await auditAction(
            user.id,
            `Changed role of user "${targetUserName}" to ${role} by SuperAdmin: ${superAdminName}`
        );

        return { success: `Successfully changed user role to ${role}` };
    } catch (error) {
        console.error("Error changing user role:", error);
        return { error: "Failed to change user role" };
    }
}