"use server";

import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db";


export const getDesignationUsers = async (designationId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const assignedUsers = await db.assignDesignation.findMany({
        where: {
            designationId: designationId
        }
    })

    if (!assignedUsers) {
        return { error: "No Users Found in this Designation" }
    };

    return { success: "Users found!", data: assignedUsers }
}