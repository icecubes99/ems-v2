
"use server"

import { db } from "@/lib/db"

export async function getHolidays() {
    const currentYear = new Date().getFullYear()
    const presentDay = new Date()
    const endOfYear = new Date(currentYear, 11, 31, 23, 59, 59)

    try {
        const holidays = await db.holiday.findMany({
            where: {
                date: {
                    gte: presentDay,
                    lte: endOfYear
                }
            },
            orderBy: {
                date: 'asc'
            }
        })
        return { holidays }
    } catch (error) {
        console.error("Error fetching holidays:", error)
        return { error: "Failed to fetch holidays" }
    }
}

export async function getSpecificHoliday(holidayId: string) {
    try {
        const holiday = await db.holiday.findUnique({
            where: {
                id: holidayId
            }
        })
        return { holiday }
    } catch (error) {
        console.error("Error fetching holiday:", error)
        return { error: "Failed to fetch holidays" }
    }
}