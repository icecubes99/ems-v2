"use server"

import * as z from "zod";

import { AddressSchema } from "@/schemas";
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";

export const editAddress = async (values: z.infer<typeof AddressSchema>) => {
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

    if (!existingAddress) {
        return { error: "User does not have an address to edit!" };
    }

    const { street, barangay, city, province, country, zipCode } = validatedFields.data;

    await auditAction(dbUser.id, "User Address Update");

    await db.addressLine.update({
        where: { userId: dbUser.id },
        data: {
            street,
            barangay,
            city,
            province,
            country,
            zipCode,
        },
    });

    return { success: "Address updated!" };
}