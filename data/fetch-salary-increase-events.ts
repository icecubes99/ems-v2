"use server"

import { db } from "@/lib/db"

export async function fetchSalaryIncreaseEvents() {
    try {
        const salaryIncrease = await db.salaryIncreaseEvent.findMany({
            orderBy: {
                appliedAt: 'desc'
            },
            include: {
                department: true,
                designation: true
            },
            where: {
                isUndone: false
            }
        })

        return { salaryIncrease }
    } catch (error) {
        console.error("Error fetching Salary Increase Events:", error)
        return { error: "Failed to fetch Salary Increase Events" }
    }
}