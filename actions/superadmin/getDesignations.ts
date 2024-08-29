"use server";

import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db";

export const getDesignationFromDepartment = async (departmentId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const designations = await db.designation.findMany({
        where: {
            departmentId
        }
    });

    if (!designations) {
        return { error: "No Designations Found in this Department" }
    };

    return { success: "Designations found!", data: designations }
}

export const getDesignations = async () => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const designations = await db.designation.findMany({});

    if (!designations) {
        return { error: "No Designations Found in this Department" }
    };

    return { success: "Designations found!", data: designations }
}