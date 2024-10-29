"use server"

import { EmployeeAllowanceSchema } from "@/schemas/payroll-index"
import * as z from "zod";
import { subDays } from "date-fns"
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { superAdmin } from "./superAdmin";
import { Status } from "@prisma/client";

export const createAllowance = async (values: z.infer<typeof EmployeeAllowanceSchema>) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = EmployeeAllowanceSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    const dbUser = await getUserById(user?.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    const { amount, endDate, startDate, status, type, userId } = validatedFields.data;

    const superAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    const auditActionResult = await auditAction(dbUser.id, `Allowance Created by Super Admin: ${superAdminName}`);

    const allowance = await db.allowance.create({
        data: {
            amount,
            endDate,
            startDate,
            status,
            type,
            userId,
        }
    });

    await Promise.all([auditActionResult, allowance]);

    return { success: "Allowance Created!" };
}

export const toggleAllowanceStatus = async (allowanceId: string) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const dbUser = await getUserById(user.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const superadminResult = await superAdmin();
    if (superadminResult.error) {
        return { error: superadminResult.error };
    }

    const allowance = await db.allowance.findFirst({
        where: {
            id: allowanceId
        }
    });

    if (!allowance) {
        return { error: "Allowance not found!" };
    }

    const status = allowance.status === Status.ACTIVE ? Status.INACTIVE : Status.ACTIVE;

    const updatedAllowance = await db.allowance.update({
        where: {
            id: allowanceId
        },
        data: {
            status
        }
    });

    const superAdminName = user?.name || `${dbUser.firstName} ${dbUser.lastName}`;
    await auditAction(dbUser.id, `Toggled Allowance Status by: ${superAdminName}`);

    return { success: "Allowance Status Toggled!" };
}