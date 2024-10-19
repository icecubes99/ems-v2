"use server"

import { DesignationSchema } from "@/schemas/superadminIndex";
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";
import { EmployeeType, Status, UserRole } from "@prisma/client";
import { createAssignedUser } from "./createAssignedUser";

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

    const { designationName, designationDescription, status, designationHeadUserId, departmentId, designationSalary } = validatedFields.data;
    const createdBy = dbUser.id;

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Designation Created by Admin: ${adminName}`);

    const designationHeadUser = await db.user.findUnique({
        where: { id: designationHeadUserId },
        include: { assignedDesignations: true }
    });

    if (designationHeadUser && designationHeadUser.role !== UserRole.SUPERADMIN) {
        await db.user.update({
            where: { id: designationHeadUserId },
            data: { role: UserRole.ADMIN },
        });
    }

    const designation = await db.designation.create({
        data: {
            designationName,
            designationDescription,
            status,
            departmentId,
            designationHeadUserId,
            designationSalary,
            createdBy,
        },
    });

    const designationId = designation.id;

    const existingAssignDesignation = await db.assignDesignation.findUnique({
        where: { userId: designationHeadUserId },
    });

    if (existingAssignDesignation) {
        await db.assignDesignation.update({
            where: { userId: designationHeadUserId },
            data: {
                employeeType: "REGULAR",
                status: "ACTIVE",
                designationId,
            },
        });
    } else {
        await db.assignDesignation.create({
            data: {
                userId: designationHeadUserId,
                employeeType: "REGULAR",
                status: "ACTIVE",
                designationId,
            },
        });
    }

    if (designationHeadUser && designationHeadUser.assignedDesignations === null) {
        const assignedUserValues = {
            userId: designationHeadUserId,
            employeeType: EmployeeType.REGULAR,
            status: Status.ACTIVE,
            designationId: designationId
        };
        const assignedUserResult = await createAssignedUser(assignedUserValues);
        if (assignedUserResult.error) {
            throw new Error(assignedUserResult.error); // Throw an error to rollback the transaction
        }
    }

    return { success: "Designation created!" };
}