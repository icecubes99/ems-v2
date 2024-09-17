"use server"

import { db } from "@/lib/db"

export async function getAttendancePasswords() {

    const presentDay = new Date()
    presentDay.setDate(presentDay.getDate() - 1)

    const tenDaysLater = new Date(presentDay)
    tenDaysLater.setDate(presentDay.getDate() + 20)

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