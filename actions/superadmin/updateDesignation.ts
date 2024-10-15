"use server"
import * as z from "zod";

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";

import { DesignationSchema } from "@/schemas/superadminIndex";
import { admin } from "../admin";
import { EmployeeType, Status, UserRole } from "@prisma/client";
import { createAssignedUser } from "./createAssignedUser";

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

    // Fetch the current state of the designation before update
    const previousDesignation = await db.designation.findUnique({
        where: { id: designationId }
    })

    if (!previousDesignation) {
        return { error: "Designation not Found!" }
    }

    const previousHeadUserId = previousDesignation.designationHeadUserId

    const { designationName, designationDescription, status, designationHeadUserId, departmentId, designationSalary } = validatedFields.data;

    await db.$transaction(async (prisma) => {
        const previousHeadUser = await prisma.user.findUnique({
            where: { id: previousHeadUserId }
        })

        if (previousHeadUser && previousHeadUser.role !== UserRole.SUPERADMIN) {
            await prisma.user.update({
                where: { id: previousHeadUserId },
                data: { role: UserRole.USER }
            });
        }

        // Checks the new Head user if its a a superadmin or not
        const designationHeadUser = await prisma.user.findUnique({
            where: { id: designationHeadUserId },
            select: {
                role: true,
                assignedDesignations: true
            }
        })

        if (designationHeadUser && designationHeadUser.role !== UserRole.SUPERADMIN) {
            await db.user.update({
                where: { id: designationHeadUserId },
                data: { role: UserRole.ADMIN }
            })
        }

        const adminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(dbUser.id, `Designation Updated by ${user.role}: ${adminName}`);



        await prisma.designation.update({
            where: { id: designationId },
            data: {
                designationName,
                designationDescription,
                status,
                designationHeadUserId,
                departmentId,
                designationSalary
            },
        });

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
    });


    return { success: "Designation updated!" };
}