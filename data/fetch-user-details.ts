"use server"

import { db } from "@/lib/db"
import { currentUser } from "@/lib/auth"
import { getUserById } from "./user"

interface UserImageResponse {
    image?: string
    error?: string
}

export async function fetchUserImage(): Promise<UserImageResponse> {
    const user = await currentUser()

    if (!user) {
        return { error: "Unauthorized!" }
    }

    try {
        const result = await db.user.findUnique({
            where: { id: user.id },
            select: { image: true }
        })

        if (result && result.image) {
            return { image: result.image }
        } else {
            return { error: "Image not found" }
        }

    } catch (error) {
        return { error: "Failed to fetch User Image" }
    }
}

export async function fetchUserDetails(userId: string) {
    const user = await getUserById(userId)

    if (!user) {
        return { error: "Unauthorized!" }
    }

    try {
        const result = await db.user.findUnique({
            where: { id: user.id },
        })

        if (result) {
            return { user: result }
        } else {
            return { error: "User not found" }
        }

    } catch (error) {
        return { error: "Failed to fetch User Details" }
    }
}