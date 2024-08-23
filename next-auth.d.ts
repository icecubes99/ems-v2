import { Gender, TwoFactorConfirmation, UserRole } from "@prisma/client";
import { Account, DefaultSession } from "next-auth";

export type ExtendedUser = DefaultSession["user"] & {
  role: UserRole;
  isTwoFactorEnabled: boolean;
  isOAuth: boolean;
  id: string;

  firstName: string;
  middleName: string;
  lastName: string;
  gender: Gender;
  birthDate: Date;
  jobTitle: string;

  email: string;
  emailVerified: Date;
  image: string;
  password: string;
  accounts: Account[];
  twoFactorConfirmation: TwoFactorConfirmation;
  twoFactorConfirmationId: string;
  address: Address;
};

export type Address = {
  id: string;
  street: string;
  barangay: string;
  city: string;
  province: string;
  country: string;
  zipCode: string;
};



declare module "next-auth" {
  interface Session {
    user: ExtendedUser;
  }
}
