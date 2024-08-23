"use server"

import * as z from "zod";

import { AddressSchema } from "@/schemas";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";

export const addAddress = async (values: z.infer<typeof AddressSchema>) => {
    const user = await currentUser();
    const validatedFields = AddressSchema.safeParse(values);

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user?.id);

    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    // Check if the user already has an address
    const existingAddress = await db.addressLine.findFirst({
        where: { userId: dbUser.id },
    });

    if (existingAddress) {
        return { error: "User already has an address!" };
    }


    const { street, barangay, city, province, country, zipCode } = validatedFields.data;

    await db.addressLine.create({
        data: {
            street,
            barangay,
            city,
            province,
            country,
            zipCode,
            userId: dbUser?.id,
        },
    });

    return { success: "Address added!" };
}