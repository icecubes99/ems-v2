"use server"

import { db } from "@/lib/db"

export async function fetchAdvanceTimesheets() {
    try {
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Set to start of the day

        const advanceTimesheets = await db.advanceTimesheet.findMany({
            orderBy: {
                startDate: 'desc'
            },
            include: {
                users: {
                    include: {
                        user: true
                    },
                }
            },
            where: {
                isUndone: false,
                startDate: {
                    gt: today
                }
            }
        })

        return { advanceTimesheets }
    } catch (error) {
        console.error("Error fetching Advance Timesheets:", error)
        return { error: "Failed to fetch Advance Timesheets" }
    }
}