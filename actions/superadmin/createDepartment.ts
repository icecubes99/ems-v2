"use server"

import { DepartmentSchema } from "@/schemas/superadminIndex";
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { superAdmin } from "./superAdmin";
import { UserRole } from "@prisma/client";

export const createDepartment = async (values: z.infer<typeof DepartmentSchema>) => {
    const user = await currentUser();
    const validatedFields = DepartmentSchema.safeParse(values);

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

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    const { departmentName, departmentDescription, status, departmentHeadUserId } = validatedFields.data;
    const createdBy = dbUser.id;

    const superaAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Department Created by SuperAdmin: ${superaAdminName}`);

    await db.user.update({
        where: {
            id: departmentHeadUserId,
        },
        data: {
            role: UserRole.ADMIN
        }
    })

    await db.department.create({
        data: {
            departmentName,
            departmentDescription,
            status,
            departmentHeadUserId,
            createdBy,
        },
    });

    return { success: "Department created!" };
}
