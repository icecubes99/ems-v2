"use server"

import { currentUser } from "@/lib/auth"
import { db } from "@/lib/db"
import { getUserById } from "./user"

export async function fetchOwnPayslips() {
    const user = await currentUser()
    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(user?.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    try {
        const payslips = await db.payrollItem.findMany({
            where: {
                userId: dbUser.id,
                payroll: {
                    payrollStatus: "APPROVED"
                }
            },
            orderBy: {
                createdAt: "desc"
            },
            include: {
                user: true,
                payroll: true,
                additionalEarningsArray: true,
                deductions: true,
                daysNotWorkedArray: true,
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
        console.error("Error fetching Payslips", error)
        return { error: "Failed to fetch Payslips" }
    }
}

export async function fetchOtherPayslips(userId: string) {
    const user = await currentUser()
    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(userId);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    try {
        const payslips = await db.payrollItem.findMany({
            where: {
                userId: dbUser.id,
                payroll: {
                    payrollStatus: "APPROVED"
                }
            },
            orderBy: {
                createdAt: "desc"
            },
            include: {
                user: true,
                payroll: true,
                additionalEarningsArray: true,
                deductions: true,
                daysNotWorkedArray: true,
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
        console.error("Error fetching Payslips", error)
        return { error: "Failed to fetch Payslips" }
    }
}