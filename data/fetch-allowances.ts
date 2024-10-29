"use server"

import { db } from "@/lib/db"
import { Status } from "@prisma/client"

export async function getActiveAllowances() {
    try {
        const allowances = await db.allowance.findMany({
            where: {
                status: Status.ACTIVE
            },
            orderBy: {
                createdAt: 'desc'
            }
        })
        return { allowances }
    } catch (error) {
        console.error("Error fetching allowances:", error)
        return { error: "Failed to fetch allowances" }
    }
}

export async function getInactiveAllowances() {
    try {
        const allowances = await db.allowance.findMany({
            where: {
                status: Status.INACTIVE
            },
            orderBy: {
                createdAt: 'desc'
            }
        })
        return { allowances }
    } catch (error) {
        console.error("Error fetching allowances:", error)
        return { error: "Failed to fetch allowances" }
    }
}