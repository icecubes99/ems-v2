"use server"

import { db } from "@/lib/db"

export async function fetchPendingLeaves() {
    try {
        const leaves = await db.leaves.findMany({
            where: {
                leaveStatus: 'PENDING'
            },
            orderBy: {
                createdAt: 'desc'
            },
            include: {
                user: true
            }

        })
        return { leaves }
    } catch (error) {
        console.error("Error fetching Leaves:", error)
        return { error: "Failed to fetch Leaves" }
    }
}