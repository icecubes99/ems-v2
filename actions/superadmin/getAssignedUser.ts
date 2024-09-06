"use server";

import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db";

export const getAssignedUser = async (assignedUserId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const assignedUser = await db.assignDesignation.findFirst({
        where: {
            id: assignedUserId
        }
    });

    if (!assignedUser) {
        return { error: "No Assigned User Found" }
    };

    return { success: "Assigned User found!", data: assignedUser }
}

export const getAssignedUserByUserId = async (userId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const assignedUser = await db.assignDesignation.findUnique({
        where: {
            userId: userId
        }
    });

    if (!assignedUser) {
        return { error: "No Assigned User Found" }
    };

    return { success: "Assigned User found!", data: assignedUser }
}