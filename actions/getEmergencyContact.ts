"use server"

import { db } from "@/lib/db"
import { getUserById } from "@/data/user"
import { currentUser } from "@/lib/auth"

export const getEmergencyContact = async (userId: string) => {
    const user = await currentUser()

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(userId);

    if (!dbUser) {
        return { error: "User not found in database!" }
    }

    // Fetch the emergency contact associated with the userId
    const emergencyContact = await db.emergencyContact.findFirst({
        where: { userId: dbUser.id },
    });

    if (!emergencyContact) {
        return { error: "Emergency contact not found!" }
    }

    return { success: "Emergency contact found!", data: emergencyContact }
}