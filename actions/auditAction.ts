import { db } from "@/lib/db";

export const auditAction = async (userId: string, action: string) => {
    await db.auditLog.create({
        data: {
            userId,
            action,
        },
    });
};