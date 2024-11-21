"use server"

import * as z from "zod";

import { EmergencyContactSchema } from "@/schemas";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { checkIsArchived } from "./checkIsArchived";

export const editEmergencyContact = async (userId: string, values: z.infer<typeof EmergencyContactSchema>) => {
    const user = await currentUser();
    const validatedFields = EmergencyContactSchema.safeParse(values);

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(userId);

    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const isArchived = await checkIsArchived(userId);
    if (isArchived.error) {
        return { error: isArchived.error };
    }

    // Check if the user already has an emergency contact
    const existingEmergencyContact = await db.emergencyContact.findFirst({
        where: { userId: dbUser.id },
    });

    if (!existingEmergencyContact) {
        return { error: "User does not have an emergency contact to edit!" };
    }

    const { firstName, middleName, lastName, relationship, contactNumber, emailAddress } = validatedFields.data;

    await auditAction(dbUser.id, "User Emergency Contact Update");

    await db.emergencyContact.update({
        where: { userId: dbUser.id },
        data: {
            firstName,
            middleName,
            lastName,
            relationship,
            contactNumber,
            emailAddress,
        },
    });

    return { success: "Emergency contact updated!" };
}