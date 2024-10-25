"use server"

import { db } from "@/lib/db"

export async function fetchPayrollItems(payrollId: string) {
    try {
        const payslips = await db.payrollItem.findMany({
            where: {
                payrollId
            },

            include: {
                user: true,
                payroll: true,
                additionalEarningsArray: true,
                deductions: true,
                timesheets: {
                    where: {
                        OR: [
                            { isLate: true },
                            { isOvertime: true }
                        ]
                    },
                    select: {
                        day: {
                            select: {
                                date: true
                            }
                        },
                        minutesLate: true,
                        minutesOvertime: true,
                        clockIn: true,
                        clockOut: true

                    },
                    orderBy: {
                        day: {
                            date: 'asc'
                        }
                    }
                }
            }
        })

        // Transform the data to match the expected client-side type
        const transformedPayslips = payslips.map(payslip => ({
            ...payslip,
            timesheets: payslip.timesheets.map(timesheet => ({
                date: timesheet.day.date,
                minutesLate: timesheet.minutesLate,
                minutesOvertime: timesheet.minutesOvertime,
                clockIn: timesheet.clockIn,
                clockOut: timesheet.clockOut
            }))
        }))

        return { payslips: transformedPayslips }
    } catch (error) {
        console.error("Error Fetching Payroll Items", error)
        return { error: "Failed to fetch Payroll Items" }
    }
}