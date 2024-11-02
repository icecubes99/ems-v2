"use server"

import { db } from "@/lib/db"
import { ArchiveType } from "@prisma/client"

export async function fetchArchives() {
    try {
        const archives = await db.archive.findMany()

        return { archives }
    } catch (error) {
        console.error("Error fetching Archives:", error)
        return { error: "Failed to fetch Archives" }
    }
}

export async function fetchSingleArchive(archiveId: string) {
    try {
        const archive = await db.archive.findUnique({
            where: {
                id: archiveId
            }
        })

        return { archive }
    } catch (error) {
        console.error("Error fetching Archive:", error)
        return { error: "Failed to fetch Archive" }
    }
}
