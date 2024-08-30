"use server"
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";

import { DepartmentSchema } from "@/schemas/superadminIndex";
import { superAdmin } from "./superAdmin";

export const updateDepartment = async (departmentId: string, values: z.infer<typeof DepartmentSchema>) => {
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
    // const createdBy = dbUser.id;

    const superaAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;


    await auditAction(dbUser.id, `Department Updated by SuperAdmin: ${superaAdminName}`);

    // TODO: Add history of Department and append the changes 
    // TODO: also add updatedby field in the department table to track who updated the department


    await db.department.update({
        where: { id: departmentId },
        data: {
            departmentName,
            departmentDescription,
            status,
            departmentHeadUserId,
        },
    });

    return { success: "Department updated!" };
}