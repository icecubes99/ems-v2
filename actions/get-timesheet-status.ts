// actions/get-timesheet-status.ts
"use server"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";

export async function getTimesheetStatus() {
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

    const timesheet = await db.timesheet.findFirst({
        where: {
            userId: dbUser.id,
            clockIn: {
                gte: today,
            },
        },
        orderBy: {
            clockIn: 'desc',
        },
    });

    if (!timesheet) {
        return { status: 'NOT_CLOCKED_IN' as const };
    }

    if (timesheet.clockOut) {
        return { status: 'CLOCKED_OUT' as const };
    }

    return { status: 'CLOCKED_IN' as const };
}