// helpers/archiveEntity.ts
import { db } from "@/lib/db"
import { ArchiveType } from "@prisma/client"

export async function archiveEntity(type: ArchiveType, entityId: string, data: any) {
    return await db.archive.create({
        data: {
            archiveType: type,
            entityId: entityId,
            entityData: data
        }
    })
}