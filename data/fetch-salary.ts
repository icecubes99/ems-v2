// data/fetch-salary-history.ts
"use server"

import { db } from "@/lib/db"

export async function fetchUserSalaryHistory(userId: string) {
    try {
        const salaryHistories = await db.salaryHistory.findMany({
            where: { userId },
            orderBy: { endDate: 'desc' },
            include: {
                user: {
                    select: {
                        firstName: true,
                        lastName: true
                    }
                }
            }
        })

        const currentSalary = await db.userSalary.findUnique({
            where: { userId },
            select: {
                basicSalary: true,
                grossSalary: true,
            }
        })

        return { salaryHistories, currentSalary }
    } catch (error) {
        console.error("Error fetching salary history:", error)
        return { error: "Failed to fetch salary history" }
    }
}

export async function fetchUserBaseSalary(userId: string) {
    try {
        const baseSalary = await db.userSalary.findUnique({
            where: { userId },
            select: { basicSalary: true }
        })
        return { baseSalary }
    } catch (error) {
        console.error("User Base Salary not found")
        return { error: "Failed to fetch Base Salary" }
    }
}