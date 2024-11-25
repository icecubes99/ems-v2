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

    const designations = await db.designation.findMany({});

    if (!designations) {
        return { error: "No Designations Found in this Department" }
    };

    return { success: "Designations found!", data: designations }
}

export const getLoneDesignation = async (designationId: string) => {

    if (!designationId) {
        return { error: "Invalid designation ID!" };
    }
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const designation = await db.designation.findUniqueOrThrow({
        where: { id: designationId }
    })

    if (!designation) {
        return { error: "Designation not found!" }
    }

    return { success: "Designation found!", data: designation };
}

export const getDesignationSalary = async (designationId: string) => {
    if (!designationId) {
        return { error: "Invalid designation ID!" };
    }

    const designation = await db.designation.findUniqueOrThrow({
        where: { id: designationId },
        select: { designationSalary: true }
    })

    if (!designation) {
        return { error: "Designation not found!" }
    }

    return { success: "Designation found!", data: designation };
}