"use server";

import { signOut } from "@/auth";
import { auditAction } from "./auditAction";
import { revalidateTag } from "next/cache";

export const logout = async (userId: string) => {
  await auditAction(userId, "User Log-Out");
  await signOut();
  revalidateTag(`user-${userId}`); // Invalidate cache entries tagged with the user's ID
};
