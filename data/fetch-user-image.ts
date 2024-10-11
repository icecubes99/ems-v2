"use server"

import { db } from "@/lib/db"
import { currentUser } from "@/lib/auth"

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