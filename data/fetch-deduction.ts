"use server"

import { db } from "@/lib/db"

export const fetchDeduction = async (deductionId: string) => {
    try {
        const deduction = await db.deductions.findUnique({
            where: { id: deductionId },
            include: {
                user: true
            }
        })
        return { deduction }
    } catch (error) {
        console.error("Error fetching Deductions:", error)
        return { error: "Failed to fetch Deductions" }
    }
}