"use server"

import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db";

export const getSpecificUser = async (userId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const specificUser = await db.user.findFirst({
        where: { id: userId },
        // include: {
        //     designation: true,
        //     department: true,
        // }
    });

    if (!specificUser) {
        return { error: "User not found!" }
    }

    return { success: "User found!", data: specificUser }
}

export const getSpecificUserDesignationHead = async (userId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const specificUser = await db.user.findFirst({
        where: { id: userId },
        include: {
            designation: true,
        }
    });

    if (!specificUser) {
        return { error: "User not found!" }
    }

    return { success: "User found!", data: specificUser }
}

export const getSpecificUserDepartmentHead = async (userId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const specificUser = await db.user.findFirst({
        where: { id: userId },
        include: {
            department: true,
        }
    });

    if (!specificUser) {
        return { error: "User not found!" }
    }

    return { success: "User found!", data: specificUser }
}