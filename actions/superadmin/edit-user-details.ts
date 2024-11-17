"use server"

import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db"
import { EditUserDetailsSchema } from "@/schemas/register-index"
import { z } from "zod"
import { superAdmin } from "./superAdmin";
import { auditAction } from "../auditAction";

export async function editUserDetails(values: z.infer<typeof EditUserDetailsSchema>) {
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

        const validatedFields = EditUserDetailsSchema.safeParse(values);
        if (!validatedFields.success) {
            return { error: "Invalid fields!" };
        }

        const { birthDate, email, firstName, gender, lastName, middleName, userId } = validatedFields.data;
        const targetUser = await getUserById(userId);
        if (!targetUser) {
            return { error: "Target user not found!" };
        }

        await db.user.update({
            where: { id: userId },
            data: {
                dateOfBirth: new Date(birthDate),
                email,
                firstName,
                gender,
                lastName,
                middleName
            }
        });

        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        const targetUserName = targetUser.firstName + " " + targetUser.lastName;
        await auditAction(
            user.id,
            `Changed user details of user "${targetUserName}"  by SuperAdmin: ${superAdminName}`
        );

        return { success: `Successfully edited user details` };
    } catch (error) {
        console.error("Error editing user details:", error)
        return { error: "Failed to edit user details" }
    }
}