"use server"

import { LeaveRequestSchema } from "@/schemas/attendance-index"
import { db } from "@/lib/db"
import * as z from "zod";


import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { UserRole } from "@prisma/client";


export const requestLeave = async (values: z.infer<typeof LeaveRequestSchema>) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = LeaveRequestSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    const dbUser = await getUserById(user.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }
    const createdBy = dbUser.id;

    const { startDate, endDate, reason, leaveType } = validatedFields.data;
    const parsedStartDate = new Date(startDate);
    const parsedEndDate = new Date(endDate);

    await auditAction(dbUser.id, `User requested leave from ${startDate} to ${endDate}`);

    await db.leaves.create({
        data: {
            startDate: parsedStartDate,
            endDate: parsedEndDate,
            reason,
            leaveType,
            userId: createdBy,
        },
    });
    return { success: "Leave request submitted!" };
}