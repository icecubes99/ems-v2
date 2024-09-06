'use server'

import { db } from "@/lib/db";
import { AssignDesignationWithUser } from "@/types/types";

export async function fetchAssignedUsers(designationId: string): Promise<AssignDesignationWithUser[]> {
    try {
        const assignedUsersWithData = await db.assignDesignation.findMany({
            where: {
                designationId: designationId
            },
            include: {
                user: true
            }
        });

        return assignedUsersWithData;
    } catch (error) {
        console.error("Error fetching assigned users:", error);
        throw new Error("Failed to fetch assigned users");
    }
}