"use server"


import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";

export const getAddress = async (userId: string) => {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(userId);

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    // Fetch the address associated with the userId
    const address = await db.addressLine.findFirst({
        where: { userId: dbUser.id },
    });

    if (!address) {
        return { error: "Address not found!" };
    }

    return { success: "Address found!", data: address };
}