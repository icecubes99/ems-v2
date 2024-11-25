"use server"
import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { put, del } from "@vercel/blob";
import { checkIsArchived } from "./checkIsArchived";
import { archiveEntity } from "./superadmin/remove/archive-entity";
import { ArchiveType } from "@prisma/client";

export async function removeDocuments(id: string) {
    const user = await currentUser()
    if (!user) {
        return { error: "Not a User" }
    }

    const isArchived = await checkIsArchived(user.id);
    if (isArchived.error) {
        return { error: isArchived.error };
    }

    const document = await db.documents.findUnique({
        where: {
            id
        }
    })

    if (!document) {
        return { error: "Document not found!" }
    }

    await del(document?.documentLink)

    const documentName = document.documentName

    await archiveEntity(ArchiveType.DOCUMENT, id, document)
    await db.documents.delete({
        where: {
            id
        }
    })

    await auditAction(user.id, "User Removed Document: " + documentName)
    return { success: "Document Removed!" }
}