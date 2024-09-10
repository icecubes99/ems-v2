"use server"

import { db } from "@/lib/db"
import { getUserById } from "@/data/user"
import { currentUser } from "@/lib/auth"

export async function fetchRemainingLeaveDays() {
    const user = await currentUser()
    const userId = user?.id

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(userId as string);

    if (!dbUser) {
        return { error: "User not found in database!" }
    }

    try {
        const vacationDays = await db.user.findUnique({
            where: { id: userId },
            // select: { vacationDays: true },
        })
        const incentiveDays = await db.user.findUnique({
            where: { id: userId },
            // select: { incentiveDays: true }
        })

        return { vacationDays, incentiveDays }
    } catch (error) {
        return { error: "Failed to fetch Remaining Leave Days" }
    }
}