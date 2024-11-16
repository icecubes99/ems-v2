"use server"
import { db } from "@/lib/db"

export async function fetchTimesheets() {
    try {
        const timesheets = await db.timesheet.findMany({
            include: {
                day: true,
                user: true
            }
        });

        return { timesheets }

    } catch (error) {
        console.error("Error fetching Timesheets:", error)
        return { error: "Failed to fetch Timesheets" }
    }
}

export async function fetchTimesheetById(timesheetId: string) {
    try {
        const timesheet = await db.timesheet.findUnique({
            where: { id: timesheetId },
            include: {
                day: true,
                user: true
            }
        });

        return { timesheet }

    } catch (error) {
        console.error("Error fetching Timesheet:", error)
        return { error: "Failed to fetch Timesheet" }
    }
}