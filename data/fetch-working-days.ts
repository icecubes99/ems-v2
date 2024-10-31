import { db } from "@/lib/db"

export async function fetchWorkingDays(startDate: Date, endDate: Date) {
    try {
        const workingDays = await db.workingDay.findMany({
            where: {
                date: {
                    gte: startDate,
                    lte: endDate
                }
            },
            orderBy: {
                date: 'asc'
            }
        })

        return { workingDays }
    } catch (error) {
        console.error("Error fetching Working Days", error)
        return { error: "Failed to fetch Working Days" }
    }
}