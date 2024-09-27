"use server"

import { db } from "@/lib/db"

export async function fetchDeductions() {
    try {
        const deductions = await db.deductions.findMany({
            where: {
                payrollItemId: null

            },
            orderBy: {
                createdAt: "desc"
            },
            include: {
                user: true
            }
        })
        return { deductions }
    } catch (error) {
        console.error("Error fetching Deductions:", error)
        return { error: "Failed to fetch Deductions" }
    }
}