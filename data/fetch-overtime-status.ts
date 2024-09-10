
"use server"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";

export async function fetchOvertimeStatus() {
    const user = await currentUser();

    if (!user) {
        throw new Error("Unauthorized");
    }

    const dbUser = await getUserById(user?.id);

    if (!dbUser) {
        throw new Error("User not found in database");
    }

    const today = new Date()
    today.setHours(0, 0, 0, 0);

    const overtime = await db.overtimes.findFirst({
        where: {
            userId: dbUser.id,
            createdAt: {
                gte: today
            },
        },
        orderBy: {
            createdAt: 'desc',
        },
    });

    if (!overtime) {
        return { status: "NOT_RECORDED" as const }
    }

    return { status: "RECORDED" as const }
}