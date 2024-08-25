"use server";

import { currentRole } from "@/lib/auth";
import { UserRole } from "@prisma/client";

export const superAdmin = async () => {
    const role = await currentRole();

    if (role === UserRole.SUPERADMIN) {
        return { success: "Allowed Server Action!" };
    }

    return { error: "Forbidden Server Action!" };
};
