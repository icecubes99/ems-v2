// actions/get-overtime-status.ts
"use server"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";

export async function getOvertimeStatus() {
    const user = await currentUser();

    if (!user) {
        throw new Error("Unauthorized");
    }

    const dbUser = await getUserById(user?.id);

    if (!dbUser) {
        throw new Error("User not found in database");
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const overtime = await db.overtimes.findFirst({
        where: {
            userId: dbUser.id,
            createdAt: {
                gte: today,
            },
        },
        orderBy: {
            createdAt: 'desc',
        },
    });

    if (!overtime) {
        return { status: 'NOT_RECORDED' as const };
    }

    if (overtime.clockOut) {
        return { status: 'COMPLETED' as const };
    }

    return { status: 'IN_PROGRESS' as const };
}