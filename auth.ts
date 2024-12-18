import NextAuth, { type DefaultSession } from "next-auth";
import { PrismaAdapter } from "@auth/prisma-adapter";
import { Gender, UserRole } from "@prisma/client";

import { getUserById } from "@/data/user";
import { getTwoFactorConfirmationByUserId } from "@/data/two-factor-confirmation";
import { db } from "@/lib/db";
import authConfig from "@/auth.config";
import { getAccountByUserId } from "./data/account";

export const {
  handlers: { GET, POST },
  auth,
  signIn,
  signOut,
} = NextAuth({
  pages: {
    signIn: "/auth/login",
    error: "/auth/error",
  },
  events: {
    async linkAccount({ user }) {
      await db.user.update({
        where: { id: user.id },
        data: { emailVerified: new Date() },
      });
    },
  },

  callbacks: {
    async signIn({ user, account }) {
      const existingUser = await getUserById(user.id);
      if (!existingUser?.emailVerified) return false;
      return true;
    },
    async session({ token, session }) {
      if (token.sub && session.user) {
        session.user.id = token.sub;
      }

      if (token.role && session.user) {
        session.user.role = token.role as UserRole;
      }

      if (session.user) {
        session.user.name = token.name;
        session.user.email = token.email as string;

        session.user.gender = token.gender as Gender;
        session.user.birthDate = token.birthDate as Date;
        session.user.firstName = token.firstName as string;
        session.user.middleName = token.middleName as string;
        session.user.lastName = token.lastName as string;
        session.user.jobTitle = token.jobTitle as string;
        session.user.lastLogin = token.lastLogin as Date;

      }

      return session;
    },
    async jwt({ token }) {
      if (!token.sub) return token;

      const existingUser = await getUserById(token.sub);

      if (!existingUser) return token;

      const existingAccount = await getAccountByUserId(existingUser.id);

      // token.isOAuth = !!existingAccount;
      token.firstName = existingUser.firstName;
      token.middleName = existingUser.middleName;
      token.lastName = existingUser.lastName;

      token.name = `${existingUser.firstName} ${existingUser.middleName} ${existingUser.lastName}`;

      token.gender = existingUser.gender;
      token.birthDate = existingUser.dateOfBirth;
      token.jobTitle = existingUser.jobTitle;

      token.email = existingUser.email;
      token.role = existingUser.role;
      token.isTwoFactorEnabled = existingUser.isTwoFactorEnabled;
      token.lastLogin = existingUser.lastLogin;

      return token;
    },
  },
  adapter: PrismaAdapter(db),
  session: { strategy: "jwt" },
  ...authConfig,
});
