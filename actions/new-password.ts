"use server";

import * as z from "zod";
import bcrypt from "bcryptjs";

import { getPasswordResetTokenByToken } from "@/data/password-token";
import { getUserByEmail, getUserById } from "@/data/user";
import { NewPasswordSchema } from "@/schemas";
import { db } from "@/lib/db";
import { auditAction } from "./auditAction";
import { currentUser } from "@/lib/auth";
import { superAdmin } from "./superadmin/superAdmin";

export const newPassword = async (
  values: z.infer<typeof NewPasswordSchema>,
  token?: string | null
) => {
  if (!token) {
    return { error: "Missing token!" };
  }

  const validatedFields = NewPasswordSchema.safeParse(values);

  if (!validatedFields.success) {
    return { error: "Invalid fields!" };
  }

  const { password } = validatedFields.data;

  const existingToken = await getPasswordResetTokenByToken(token);

  if (!existingToken) {
    return { error: "Invalid token!" };
  }

  const hasExpired = new Date(existingToken.expires) < new Date();

  if (hasExpired) {
    return { error: "Token has expired!" };
  }

  const existingUser = await getUserByEmail(existingToken.email);

  if (!existingUser) {
    return { error: "Email does not exist!" };
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  await auditAction(existingUser.id, "User Password Reset");

  await db.user.update({
    where: { id: existingUser.id },
    data: { password: hashedPassword },
  });

  await db.passwordResetToken.delete({
    where: { id: existingToken.id },
  });

  return { success: "Password updated!" };
};

export const newPasswordProfile = async (values: z.infer<typeof NewPasswordSchema>) => {
  const user = await currentUser();
  if (!user) {
    return { error: "Unauthorized!" };
  }

  const dbUser = await getUserById(user?.id);
  if (!dbUser) {
    return { error: "User not found in database!" };
  }

  const validatedFields = NewPasswordSchema.safeParse(values);
  if (!validatedFields.success) {
    return { error: "Invalid fields!" };
  }

  const { password } = validatedFields.data;

  const hashedPassword = await bcrypt.hash(password, 10);

  await auditAction(user.id, "User Password Reset");
  try {

    await db.user.update({
      where: { id: user.id },
      data: { password: hashedPassword },
    });

    return { success: "Password updated!" };
  } catch (error) {
    console.log("Error in updating Password:", error)
    return { error: "Error in updating Password" }
  }
}

export const newPasswordOtherProfile = async (userId: string, values: z.infer<typeof NewPasswordSchema>) => {
  const user = await currentUser();
  if (!user) {
    return { error: "Unauthorized!" };
  }

  const dbUser = await getUserById(userId);
  if (!dbUser) {
    return { error: "User not found in database!" };
  }

  const superAdminResult = await superAdmin();
  if (superAdminResult.error) {
    return { error: `Unauthorized: ${superAdminResult.error}` };
  }

  const validatedFields = NewPasswordSchema.safeParse(values);
  if (!validatedFields.success) {
    return { error: "Invalid fields!" };
  }

  const { password } = validatedFields.data;

  const hashedPassword = await bcrypt.hash(password, 10);

  await auditAction(user.id, "User Password Reset");
  try {

    await db.user.update({
      where: { id: dbUser.id },
      data: { password: hashedPassword },
    });

    return { success: "Password updated for the Employee!" };
  } catch (error) {
    console.log("Error in updating Password:", error)
    return { error: "Error in updating Password" }
  }
}