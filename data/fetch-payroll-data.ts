"use server"

import { db } from "@/lib/db"

export async function fetchPendingPayroll() {
    try {
        const payroll = await db.payroll.findMany({
            where: {
                payrollStatus: "PENDING"
            },
            orderBy: {
                createdAt: 'desc'
            },
            include: {
                payrollItems: true
            }
        });
        return { payroll }
    } catch (error) {
        console.error("Error fetching Pending Payroll:", error)
        return { error: "Failed to fetch Pending Payroll" }
    }
}

export async function fetchApprovedDeniedPayroll() {
    try {
        const payroll = await db.payroll.findMany({
            where: {
                NOT: {
                    payrollStatus: "PENDING"
                }
            },
            orderBy: {
                createdAt: 'desc'
            },
            include: {
                payrollItems: true
            }
        });
        return { payroll }
    } catch (error) {
        console.error("Error fetching Payroll:", error)
        return { error: "Failed to fetch Payroll" }
    }
}

export async function fetchPayroll(payrollId: string) {
    try {
        const payroll = await db.payroll.findUnique({
            where: {
                id: payrollId
            },
            include: {
                payrollItems: true
            }
        });
        return { payroll }
    } catch (error) {
        console.error("Error fetching Payroll:", error)
        return { error: "Failed to fetch Payroll" }
    }
}