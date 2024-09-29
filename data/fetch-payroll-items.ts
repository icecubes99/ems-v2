"use server"

import { db } from "@/lib/db"

export async function fetchPayrollItems(payrollId: string) {
    try {
        const payrollItems = await db.payrollItem.findMany({
            where: {
                payrollId
            },
            include: {
                user: true,
                payroll: true,
                additionalEarningsArray: true,
                deductions: true
            }
        })
        return { payrollItems }
    } catch (error) {
        console.error("Error Fetching Payroll Items", error)
        return { error: "Failed to fetch Payroll Items" }
    }
}