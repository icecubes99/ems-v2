"use server"
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";

import { DesignationSchema } from "@/schemas/superadminIndex";
import { admin } from "../admin";

export const updateDesignation = async (designationId: string, values: z.infer<typeof DesignationSchema>) => {

    const user = await currentUser();
    const validatedFields = DesignationSchema.safeParse(values);

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

    const { designationName, designationDescription, status, designationHeadUserId, departmentId } = validatedFields.data;

    const adminName = user.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Designation Updated by ${user.role}: ${adminName}`);

    await db.designation.update({
        where: { id: designationId },
        data: {
            designationName,
            designationDescription,
            status,
            designationHeadUserId,
            departmentId,
        },
    });

    return { success: "Designation updated!" };
}