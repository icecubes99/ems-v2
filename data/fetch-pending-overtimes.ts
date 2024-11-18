"use server"

import { db } from "@/lib/db"

export async function fetchPendingOvertimes() {
    try {
        const overtime = await db.overtimes.findMany({
            where: {
                status: 'PENDING'
            },
            orderBy: {
                createdAt: 'desc'
            },
            include: {
                user: true
            }

        })
        return { overtime }
    } catch (error) {
        console.error("Error fetching Pending Overtimes:", error)
        return { error: "Failed to fetch Pending Overtimes" }
    }
}

export async function fetchApprovedDeniedOvertimes() {
    try {
        const overtime = await db.overtimes.findMany({
            where: {
                OR: [
                    { status: 'COMPLETED' },
                    { status: 'REJECTED' }
                ]
            },
            orderBy: {
                createdAt: 'desc'
            },
            include: {
                user: true
            }

        })
        return { overtime }
    } catch (error) {
        console.error("Error fetching Pending Overtimes:", error)
        return { error: "Failed to fetch Pending Overtimes" }
    }
}