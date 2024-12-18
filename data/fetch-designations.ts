"use server"

import { db } from "@/lib/db"

export async function fetchDesignations() {
    try {
        const designations = await db.designation.findMany({
            orderBy: {
                designationName: 'asc'
            }
        })
        return { designations }
    } catch (error) {
        console.error("Error fetching Designations:", error)
        return { error: "Failed to fetch Designations" }
    }
}