"use server"

import { DeductionsSchema, DeductionsSchemaWithUser } from "@/schemas/payroll-index";
import * as z from "zod";

import { startOfDay, endOfDay, subMonths, setDate, differenceInMinutes, subDays } from "date-fns"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";
import { UserRole } from "@prisma/client";

export const addDeductionsToUser = async (values: z.infer<typeof DeductionsSchema>) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = DeductionsSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    const dbUser = await getUserById(user?.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const { userId, amount, deductionType, description } = validatedFields.data;

    const createdBy = dbUser.id;
    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Deduction Added by Admin: ${adminName}`);

    await db.deductions.create({
        data: {
            userId,
            amount,
            deductionType,
            description,
        }
    });

    return { success: "Deduction Added!" };
}

export const addDeductionsCorrection = async (values: z.infer<typeof DeductionsSchemaWithUser>, userId: string, payrollItemId: string, payrollId: string) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = DeductionsSchemaWithUser.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid fields! validated fields" };
    }

    const dbUser = await getUserById(user?.id);
    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    const adminResult = await admin();
    if (adminResult.error) {
        return { error: adminResult.error };
    }

    const { amount, deductionType, description } = validatedFields.data;

    const createdBy = dbUser.id;
    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    const sixDaysAgo = subDays(new Date(), 6);

    await auditAction(dbUser.id, `Deduction Added by Admin: ${adminName}`);

    await db.deductions.create({
        data: {
            amount,
            deductionType,
            description,

            userId,
            createdAt: sixDaysAgo,
            payrollItemId
        }
    });

    // updating Payrollitem 
    const payrollItem = await db.payrollItem.findFirst({
        where: {
            id: payrollItemId
        }
    })

    if (!payrollItem) {
        return { error: "No Payroll Item Found" }
    }

    const { netSalary, totalDeductions, } = payrollItem

    let newTotalDeductions
    let newNetSalary = netSalary
    let payrollAmountForTotal = amount

    if (newNetSalary <= 0) {
        newNetSalary = netSalary
        newTotalDeductions = totalDeductions
        payrollAmountForTotal = 0
    } else {
        newNetSalary = netSalary - amount
        newTotalDeductions = totalDeductions + amount
    }


    await db.payrollItem.update({
        where: {
            id: payrollItemId
        },
        data: {
            netSalary: newNetSalary,
            totalDeductions: newTotalDeductions
        }
    })

    // updating Payroll itself
    const payroll = await db.payroll.findFirst({
        where: {
            id: payrollId
        }
    })

    if (!payroll) {
        return { error: "Payroll not Found" }
    }

    const { totalAmount } = payroll
    const newTotalAmount = totalAmount - payrollAmountForTotal

    await db.payroll.update({
        where: {
            id: payrollId
        },
        data: {
            totalAmount: newTotalAmount
        }
    })

    return { success: "Deduction Added!" };
}