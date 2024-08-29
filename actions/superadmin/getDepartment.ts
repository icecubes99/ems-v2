"use server"

import { currentUser } from "@/lib/auth"
import { db } from "@/lib/db"

export const getDepartment = async (departmentId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const department = await db.department.findFirst({
        where: { id: departmentId },
    });

    if (!department) {
        return { error: "Department not found!" };
    }

    return { success: "Department found!", data: department };
}