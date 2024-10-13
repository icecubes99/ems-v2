"use server";

import * as z from "zod";
import bcrypt from "bcrypt";

import { newRegisterSchema } from "@/schemas/register-index";
import { db } from "@/lib/db";
import { getUserByEmail, getUserById } from "@/data/user";
import { generateVerificationToken } from "@/lib/tokens";
import { sendVerificationEmail } from "@/lib/mail";
import { currentUser } from "@/lib/auth";
import { superAdmin } from "./superAdmin";
import { auditAction } from "../auditAction";

export const newRegister = async (values: z.infer<typeof newRegisterSchema>) => {

    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user.id);
    if (!dbUser) {
        return { error: "User not found in database!" }
    }

    const superadminResult = await superAdmin();
    if (superadminResult.error) {
        return { error: superadminResult.error }
    }


    const validatedFields = newRegisterSchema.safeParse(values);

    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    const {
        email,
        password,
        firstName,
        middleName,
        lastName,
        gender,
        birthDate,
        role,
        jobTitle,
        designationId,
        employeeType,
        status,
        basicSalary,
        sssNumber,
        tinNumber,
        philHealthNumber,
        pagIbigNumber,
    } = validatedFields.data;

    const hashedPassword = await bcrypt.hash(password, 10);

    const existingUser = await getUserByEmail(email);

    const designationSalary = await db.designation.findUnique({
        where: { id: designationId },
        select: { designationSalary: true }
    })

    if (existingUser) {
        return { error: "Email already in use!" };
    }

    try {
        await db.$transaction(async (prisma) => {
            const user = await prisma.user.create({
                data: {
                    firstName,
                    middleName,
                    lastName,
                    email,
                    password: hashedPassword,
                    gender,
                    dateOfBirth: new Date(birthDate),
                    jobTitle,
                    role,
                },
            });

            await prisma.assignDesignation.create({
                data: {
                    userId: user.id,
                    designationId,
                    employeeType,
                    status,
                },
            });

            await prisma.userSalary.create({
                data: {
                    userId: user.id,
                    basicSalary,
                    grossSalary: basicSalary + (designationSalary?.designationSalary ?? 0)
                },
            });

            await prisma.governmentId.create({
                data: {
                    userId: user.id,
                    sssNumber,
                    tinNumber,
                    philHealthNumber,
                    pagIbigNumber,
                },
            });
        });

        const verificationToken = await generateVerificationToken(email);
        await sendVerificationEmail(verificationToken.email, verificationToken.token);

        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(user.id, `User Created by SuperAdmin: ${superAdminName}`);


        return { success: "User registered successfully. Confirmation email sent!" };
    } catch (error) {
        console.error("Error during registration:", error);
        return { error: "An error occurred during registration." };
    }
};