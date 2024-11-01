'use server'

import { db } from "@/lib/db";
import { User } from "@prisma/client";

export async function fetchUserList(): Promise<User[]> {
    const allUsers = await db.user.findMany();

    return allUsers.map(user => ({
        ...user,
        name: `${user.firstName} ${user.lastName}`
    }));
}

export async function fetchDesignationHeadUserList(currentHeadId: string) {
    const users = await db.user.findMany({
        where: {
            OR: [
                { designation: null },
                ...(currentHeadId ? [{ id: currentHeadId }] : [])
            ]
        }
    });
    return users.map(user => ({
        ...user,
        name: `${user.firstName} ${user.lastName}`
    }));
}
export async function fetchDepartmentHeadUserList(currentHeadId: string) {
    const users = await db.user.findMany({
        where: {
            OR: [
                { department: null },
                ...(currentHeadId ? [{ id: currentHeadId }] : [])
            ]
        }
    });
    return users.map(user => ({
        ...user,
        name: `${user.firstName} ${user.lastName}`
    }));
}