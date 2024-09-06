"use server"

import { db } from "@/lib/db"

export async function getAttendancePasswords() {

    const presentDay = new Date()

    const tenDaysLater = new Date(presentDay)
    tenDaysLater.setDate(presentDay.getDate() + 10)
    const currentYear = new Date().getFullYear()
    const endOfYear = new Date(currentYear, 11, 31, 23, 59, 59)

    try {
        const days = await db.workingDay.findMany({
            where: {
                date: {
                    gte: presentDay,
                    lte: tenDaysLater
                }
            },
            orderBy: {
                date: 'asc'
            }
        })
        return { days }
    } catch (error) {
        console.error("Error fetching Passwords:", error)
        return { error: "Failed to fetch Passwords" }
    }
}