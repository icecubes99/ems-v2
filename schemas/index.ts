import { Gender, UserRole } from "@prisma/client";
import * as z from "zod";

export const LoginSchema = z.object({
  email: z.string().email({
    message: "Email is required",
  }),
  password: z.string().min(1, {
    message: "Password is required",
  }),
  code: z.optional(z.string()),
});

export const RegisterSchema = z.object({
  email: z.string().email({
    message: "Email is required",
  }),
  password: z.string().min(6, {
    message: "Minimum 6 characters required",
  }),
  firstName: z.string().min(1, {
    message: "First Name is required",
  }),
  middleName: z.string().min(1, {
    message: "Middle Name is required",
  }),
  lastName: z.string().min(1, {
    message: "Last Name is required",
  }),
  gender: z.enum([Gender.MALE, Gender.FEMALE, Gender.OTHER]),
  birthDate: z.string().min(1, {
    message: "Birth Date is Required"
  }),
});

export const AddressSchema = z.object({
  street: z.string().min(1, {
    message: "Street is required",
  }),
  barangay: z.string().min(1, {
    message: "Barangay is required",
  }),
  city: z.string().min(1, {
    message: "City is required",
  }),
  province: z.string().min(1, {
    message: "Province is required",
  }),
  country: z.string().min(1, {
    message: "Country is required",
  }),
  zipCode: z.string().min(1, {
    message: "Country is required",
  }),
})

export const ResetSchema = z.object({
  email: z.string().email({
    message: "Email is required",
  }),
});

export const NewPasswordSchema = z.object({
  password: z.string().min(6, {
    message: "Minimum 6 characters required!",
  }),
});

export const SettingsSchema = z
  .object({
    name: z.optional(z.string()),
    isTwoFactorEnabled: z.optional(z.boolean()),
    role: z.enum([UserRole.ADMIN, UserRole.USER, UserRole.SUPERADMIN]),
    email: z.optional(z.string().email()),
    password: z.optional(z.string().min(6)),
    newPassword: z.optional(z.string().min(6)),
  })
  .refine(
    (data) => {
      if (data.password && !data.newPassword) {
        return false;
      }

      return true;
    },
    {
      message: "New password is required!",
      path: ["newPassword"],
    }
  )
  .refine(
    (data) => {
      if (data.newPassword && !data.password) {
        return false;
      }

      return true;
    },
    {
      message: "Password is required!",
      path: ["password"],
    }
  );
