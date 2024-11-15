"use server"

import { db } from "@/lib/db"

export async function fetchPayrollItemTimesheets(payrollItemId: string) {
    try {
        const payrollItem = await db.payrollItem.findUnique({
            where: {
                id: payrollItemId
            },
            select: {
                timesheets: {
                    include: {
                        day: true
                    }
                }
            }
        });

        if (!payrollItem) {
            return { error: "Payroll Item not found" }
        };

        return { payrollItemTimesheets: payrollItem.timesheets }

    } catch (error) {
        console.error("Error fetching Payroll Item Timesheets:", error)
        return { error: "Failed to fetch Payroll Item Timesheets" }
    }
}