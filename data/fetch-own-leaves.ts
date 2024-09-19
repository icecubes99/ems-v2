"use server"

import { currentUser } from "@/lib/auth"
import { db } from "@/lib/db"
import { getUserById } from "./user"

export async function fetchOwnLeaves() {
    const user = await currentUser()
    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(user?.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    try {
        const leaves = await db.leaves.findMany({
            where: {
                userId: dbUser.id
            },
            orderBy: {
                createdAt: 'desc'
            }

        })
        return { leaves }
    } catch (error) {
        console.error("Error fetching Leaves:", error)
        return { error: "Failed to fetch Leaves" }
    }
}

export async function fetchOtherLeaves(userId: string) {
    const user = await currentUser()
    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(userId);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    try {
        const leaves = await db.leaves.findMany({
            where: {
                userId: dbUser.id
            },
            orderBy: {
                createdAt: 'desc'
            }

        })
        return { leaves }
    } catch (error) {
        console.error("Error fetching Leaves:", error)
        return { error: "Failed to fetch Leaves" }
    }
}