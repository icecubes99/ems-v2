"use server"
import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";

export async function removeDocuments(id: string) {
    const user = await currentUser()
    if (!user) {
        return { error: "Not a User" }
    }
    const document = await db.documents.findUnique({
        where: {
            id
        }
    })

    const documentName = document?.documentName

    if (!document) {
        return { error: "Document not found!" }
    }

    await db.documents.delete({
        where: {
            id
        }
    })

    await auditAction(user.id, "User Removed Document: " + documentName)
    return { success: "Document Removed!" }
}