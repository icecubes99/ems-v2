"use server"

import { db } from "@/lib/db"

export async function fetchAdditionalEarnings() {
    try {
        const additionalEarnings = await db.additionalEarnings.findMany({
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
        return { additionalEarnings }
    } catch (error) {
        console.error("Error fetching Additional Earnings:", error)
        return { error: "Failed to fetch Additional Earnings" }
    }
}


export const fetchAdditionalEarning = async (additionalEarningId: string) => {
    try {
        const additionalEarning = await db.additionalEarnings.findUnique({
            where: { id: additionalEarningId },
            include: {
                user: true
            }
        })
        return { additionalEarning }
    } catch (error) {
        console.error("Error fetching Additional Earning:", error)
        return { error: "Failed to fetch Additional Earning" }
    }
}