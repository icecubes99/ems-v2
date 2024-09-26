"use server";

import { signOut } from "@/auth";
import { auditAction } from "./auditAction";
import { revalidateTag } from "next/cache";
import { destroyCookie } from "nookies";

export const logout = async (userId: string) => {
  await auditAction(userId, "User Log-Out");
  destroyCookie(null, 'next-auth.session-token', { path: '/' });

  await signOut({ redirectTo: "/homepage" });
};
