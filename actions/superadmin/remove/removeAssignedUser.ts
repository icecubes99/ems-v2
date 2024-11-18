"use server"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../../auditAction";
import { admin } from "../../admin";

export const removeAssignedUser = async (assignedUserId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user.id);

    if (!dbUser) {
        return { error: "User not found in database" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const assignedUser = await db.assignDesignation.findUnique({
        where: {
            id: assignedUserId
        }
    });

    if (!assignedUser) {
        return { error: "User not found in database" };
    }

    const { userId } = assignedUser;
    const userToRemove = await getUserById(userId);

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    const designation = await db.designation.findUnique({
        where: { id: assignedUser.designationId },
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
                startDate: new Date(userSalary.userSalary.updatedAt),
                amountIncreased: 0,
            }
        })
    }

    if (userSalary && userSalary.userSalary) {
        await db.userSalary.update({
            where: { id: userSalary.userSalary.id },
            data: {
                grossSalary: userSalary.userSalary.basicSalary,
            }
        });
    } else {
        return { error: "User salary not found" };
    }


    await auditAction(dbUser.id, `User "${userToRemove?.firstName} ${userToRemove?.lastName}" removed from designation by Admin: ${adminName}`);

    await db.assignDesignation.delete({
        where: { id: assignedUserId }
    });

    return { success: "User removed from designation!" };
}