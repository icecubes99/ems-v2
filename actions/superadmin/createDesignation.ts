"use server"

import { DesignationSchema } from "@/schemas/superadminIndex";
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";
import { UserRole } from "@prisma/client";


export const createDesignation = async (values: z.infer<typeof DesignationSchema>) => {
    const user = await currentUser();
    const validatedFields = DesignationSchema.safeParse(values);

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user?.id);

    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const { designationName, designationDescription, status, designationHeadUserId, departmentId } = validatedFields.data;
    const createdBy = dbUser.id;

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;


    await auditAction(dbUser.id, `Designation Created by Admin: ${adminName}`);

    const designationHeadUser = await db.user.findUnique({
        where: { id: designationHeadUserId }
    })

    if (designationHeadUser && designationHeadUser.role !== UserRole.SUPERADMIN) {
        await db.user.update({
            where: { id: designationHeadUserId },
            data: { role: UserRole.ADMIN }
        })
    }

    await db.designation.create({
        data: {
            designationName,
            designationDescription,
            status,
            departmentId,
            designationHeadUserId,
            createdBy,
        },
    });

    return { success: "Designation created!" };
}