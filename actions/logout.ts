"use server";

import { signOut } from "@/auth";
import { auditAction } from "./auditAction";

export const logout = async (userId: string) => {

  await auditAction(userId, "User Log-Out");
  await signOut();
};
