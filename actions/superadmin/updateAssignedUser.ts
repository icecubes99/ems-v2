"use server"

import { AssignedDesignationSchema } from "@/schemas/superadminIndex"
import * as z from "zod"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";

export const updateAssignedUser = async (assignedUserId: string, values: z.infer<typeof AssignedDesignationSchema>) => {
    const user = await currentUser();
    const validatedFields = AssignedDesignationSchema.safeParse(values);

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user.id);

    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    if (!dbUser) {
        return { error: "User not found in database" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const { userId, employeeType, status, designationId } = validatedFields.data;
    const assignedUser = await getUserById(userId);


    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;
    const assignedUserName = assignedUser?.firstName + " " + assignedUser?.lastName;

    await auditAction(dbUser.id, `User "${assignedUserName}" assignment details updated by Admin: ${adminName}`);

    await db.assignDesignation.update({
        where: { id: assignedUserId },
        data: {
            userId,
            employeeType,
            status,
            designationId,
        },
    });

    return { success: "User assignment details updated!" };
}