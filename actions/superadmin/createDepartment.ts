"use server"

import { DepartmentSchema } from "@/schemas/superadminIndex";
import * as z from "zod";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { superAdmin } from "./superAdmin";
import { UserRole, Prisma } from "@prisma/client"; // Add Prisma import

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

    // Check for existing department with same name
    const existingDepartment = await db.department.findFirst({
        where: {
            departmentName: {
                equals: departmentName,
                mode: 'insensitive' // Case insensitive comparison
            }
        }
    });

    if (existingDepartment) {
        return { error: "Department with this name already exists!" };
    }

    try {
        const departmentHeadUser = await db.user.findUnique({
            where: { id: departmentHeadUserId }
        });

        if (departmentHeadUser && departmentHeadUser.role !== UserRole.SUPERADMIN) {
            await db.user.update({
                where: { id: departmentHeadUserId },
                data: { role: UserRole.ADMIN }
            });
        }

        await db.department.create({
            data: {
                departmentName,
                departmentDescription,
                status,
                departmentHeadUserId,
                createdBy,
            },
        });

        const superAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(dbUser.id, `Department Created by SuperAdmin: ${superAdminName}`);

        return { success: "Department created!" };

    } catch (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            if (error.code === 'P2002') { // Unique constraint violation
                return { error: "A department with this name already exists." };
            }
        }
        console.error("Error creating department:", error);
        return { error: "Failed to create department" };
    }
}