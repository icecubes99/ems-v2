"use server"
import { db } from "@/lib/db";

export async function fetchAuditLogs() {
    try {
        const auditLogs = await db.auditLog.findMany({
            orderBy: {
                createdAt: "desc"
            },
            include: {
                user: true
            }
        })
        return { auditLogs }
    } catch (error) {
        console.log("Error fetching audit logs:", error)
        return { error: "Failed to fetch Additional Earning" }
    }
}

export async function fetchSingleAuditLog(userId: string) {
    try {
        const auditLog = await db.auditLog.findMany({
            where: { userId: userId },
            orderBy: {
                createdAt: "desc"
            },
            include: {
                user: true
            }
        })
        return { auditLog }
    } catch (error) {
        console.log("Error fetching single audit log:", error)
        return { error: "Failed to fetch single audit log" }
    }
}