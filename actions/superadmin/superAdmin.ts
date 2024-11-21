"use server";

import { currentRole, currentUserId } from "@/lib/auth";
import { UserRole } from "@prisma/client";
import { checkIsArchived } from "../checkIsArchived";

export const superAdmin = async () => {
    const role = await currentRole();
    const userId = await currentUserId();

    if (!userId) {
        return { error: "User not found in database!" }
    }
    const isArchivedResult = await checkIsArchived(userId);
    if (isArchivedResult.error) {
        return { error: isArchivedResult.error }
    }

    if (role === UserRole.SUPERADMIN) {
        return { success: "Allowed Server Action!" };
    }

    return { error: "Forbidden Server Action!" };
};
