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