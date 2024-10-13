"use server"

import { AssignedDesignationSchema } from "@/schemas/superadminIndex"
import * as z from "zod"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";

export const createAssignedUser = async (values: z.infer<typeof AssignedDesignationSchema>) => {
    const user = await currentUser();
    const validatedFields = AssignedDesignationSchema.safeParse(values);

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

    const { userId, employeeType, status, designationId } = validatedFields.data;
    const assignedUser = await getUserById(userId);

    // const createdBy = dbUser.id;

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;
    const assignedUserName = assignedUser?.firstName + " " + assignedUser?.lastName;

    const designation = await db.designation.findUnique({
        where: { id: designationId },
    });

    const userSalary = await db.user.findUnique({
        where: { id: userId },
        select: {
            userSalary: true,
        }
    })

    if (userSalary && userSalary.userSalary) {
        await db.salaryHistory.create({
            data: {
                userId,
                basicSalary: userSalary.userSalary.basicSalary,
                grossSalary: userSalary.userSalary.grossSalary ?? userSalary.userSalary.basicSalary,
                startDate: new Date(userSalary.userSalary.updatedAt)
            }
        })
    }

    if (userSalary && userSalary.userSalary) {
        await db.userSalary.update({
            where: { id: userSalary.userSalary.id },
            data: {
                grossSalary: userSalary.userSalary.basicSalary + (designation?.designationSalary ?? 0),
            }
        });
    } else {
        return { error: "User salary not found" };
    }

    await auditAction(dbUser.id, `User "${assignedUserName}" assigned to a designation by Admin: ${adminName}`);

    await db.assignDesignation.create({
        data: {
            userId,
            employeeType,
            status,
            designationId,
        },
    });

    return { success: "User assigned to designation!" };
}