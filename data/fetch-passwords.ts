"use server"

import bcrypt from "bcryptjs";

import { currentUser } from "@/lib/auth"
import { db } from "@/lib/db"
import { getUserByEmail, getUserById } from "./user"

export async function getAttendancePasswords() {

    const presentDay = new Date()
    presentDay.setDate(presentDay.getDate() - 1)

    const tenDaysLater = new Date(presentDay)
    tenDaysLater.setDate(presentDay.getDate() + 20)

    try {
        const days = await db.workingDay.findMany({
            where: {
                date: {
                    gte: presentDay,
                    lte: tenDaysLater
                }
            },
            orderBy: {
                date: 'asc'
            }
        })
        return { days }
    } catch (error) {
        console.error("Error fetching Passwords:", error)
        return { error: "Failed to fetch Passwords" }
    }
}
export async function verifyUserPassword(inputPassword: string) {
    const user = await currentUser();
    if (!user || !user.email) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserByEmail(user.email);
    if (!dbUser || !dbUser.password) {
        return { error: "User not found or no password set!" };
    }

    try {
        console.log("Verifying password for user:", dbUser.email);

        const isMatch = await bcrypt.compare(inputPassword, dbUser.password);
        console.log("Password match result:", isMatch);

        if (!isMatch) {
            return { error: "Incorrect password!" };
        }

        return { success: "Password verified!" };
    } catch (error) {
        console.error("Error in password verification:", error);
        return { error: "Failed to verify password" };
    }
}