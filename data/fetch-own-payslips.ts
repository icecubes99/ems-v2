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
                userId: dbUser.id
            },
            orderBy: {
                createdAt: "desc"
            },
            include: {
                user: true,
                payroll: true
            }

        })
        return { payslips }
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
                userId: dbUser.id
            },
            orderBy: {
                createdAt: "desc"
            }
        })
        return { payslips }
    } catch (error) {
        console.error("Error fetching Payslips", error)
        return { error: "Failed to fetch Payslips" }
    }
}