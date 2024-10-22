"use server"

import { db } from "@/lib/db"

export async function fetchUserDocuments(userId: string) {
    try {
        const userDocuments = await db.documents.findMany({
            where: {
                userId: userId
            },
            orderBy: {
                createdAt: 'desc'
            }
        })

        return { userDocuments }
    } catch (error) {
        console.error("Error fetching User Documents:", error)
        return { error: "Failed to fetch User Documents" }
    }
}

export async function fetchAllDocuments() {
    try {
        const documents = await db.documents.findMany({
            orderBy: {
                createdAt: 'desc'
            },
            include: {
                user: true
            },
        })

        return { documents }
    } catch (error) {
        console.error("Error fetching Documents:", error)
        return { error: "Failed to fetch Documents" }
    }
}

export async function fetchSingleDocument(documentId: string) {
    try {
        const document = await db.documents.findUnique({
            where: {
                id: documentId
            }
        })

        return { document }
    } catch (error) {
        console.error("Error fetching single document:", error)
        return { error: "Failed to fetch single document" }
    }
}