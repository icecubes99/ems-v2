"use server"
import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { DepartmentSchema } from "@/schemas/superadminIndex";
import { superAdmin } from "./superAdmin";
import { UserRole } from "@prisma/client";

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

    // Fetch the current state of the department
    const previousDepartment = await db.department.findUnique({
        where: { id: departmentId },
    });

    if (!previousDepartment || !previousDepartment.id) {
        return { error: "Department not found!" };
    }

    const previousHeadUserId = previousDepartment.departmentHeadUserId;
    const { departmentName, departmentDescription, status, departmentHeadUserId } = validatedFields.data;

    // Check if the previous head user is not a super admin before updating their role
    const previousHeadUser = await db.user.findUnique({
        where: { id: previousHeadUserId || undefined },
    });

    if (previousHeadUser && previousHeadUser.role !== UserRole.SUPERADMIN) {
        await db.user.update({
            where: { id: previousHeadUserId || undefined },
            data: { role: UserRole.USER }
        });
    }

    // Check if the new head user is not a super admin before updating their role
    const newHeadUser = await db.user.findUnique({
        where: { id: departmentHeadUserId },
    });

    if (newHeadUser && newHeadUser.role !== UserRole.SUPERADMIN) {
        await db.user.update({
            where: { id: departmentHeadUserId },
            data: { role: UserRole.ADMIN }
        });
    }

    const superAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Department Updated by SuperAdmin: ${superAdminName}`);

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