"use server"

import { AdditionalEarningsSchema, AdditionalEarningsSchemaWithUser } from "@/schemas/payroll-index";
import * as z from "zod";
import { subDays } from "date-fns"

import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { admin } from "../admin";

export const addAdditionalEarningsToUser = async (values: z.infer<typeof AdditionalEarningsSchema>) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = AdditionalEarningsSchema.safeParse(values);
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

    const { userIds, amount, earningType, description } = validatedFields.data;

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Additional Earnings Added by Admin: ${adminName}`);

    const additionaEarningsPromises = userIds.map(userId => {
        return db.additionalEarnings.create({
            data: {
                userId,
                amount,
                earningType,
                description,
            }
        });

    })

    await Promise.all(additionaEarningsPromises);

    return { success: "Additional Earnings Added!" };
}

export const addAdditionalEarningsToUserCorrections = async (values: z.infer<typeof AdditionalEarningsSchemaWithUser>, userId: string, payrollItemId: string, payrollId: string) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const validatedFields = AdditionalEarningsSchemaWithUser.safeParse(values);
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

    const { amount, earningType, description } = validatedFields.data;

    const adminName = user?.name || dbUser.firstName + " " + dbUser.lastName;

    const sixDaysAgo = subDays(new Date(), 6);

    await auditAction(dbUser.id, `Additional Earnings Added by Admin: ${adminName}`);

    await db.additionalEarnings.create({
        data: {
            amount,
            earningType,
            description,

            payrollItemId,
            userId,
            createdAt: sixDaysAgo,
        }
    });

    // update payroll item
    const payrollItem = await db.payrollItem.findFirst({
        where: {
            id: payrollItemId
        }
    })

    if (!payrollItem) {
        return { error: "No Payroll Item Found" }
    }

    const { netSalary, totalDeductions, basicSalary, overtimeSalary, additionalEarnings } = payrollItem

    let newNetSalary = netSalary
    const grossSalary = basicSalary + overtimeSalary + additionalEarnings + amount
    let payrollAmountForTotal = amount

    if (grossSalary < totalDeductions) {
        newNetSalary = netSalary
        payrollAmountForTotal = 0
    } else {
        newNetSalary = (netSalary + amount) - totalDeductions
    }

    await db.payrollItem.update({
        where: {
            id: payrollItemId
        },
        data: {
            additionalEarnings: additionalEarnings + amount,
            netSalary: newNetSalary
        }
    })

    // update payroll

    const payroll = await db.payroll.findFirst({
        where: {
            id: payrollId
        }
    })

    if (!payroll) {
        return { error: "No Payroll Found" }
    }

    const { totalAmount } = payroll
    const newTotalAmount = totalAmount + newNetSalary

    await db.payroll.update({
        where: {
            id: payrollId
        },
        data: {
            totalAmount: newTotalAmount
        }
    })

    return { success: "Additional Earnings Added!" };
}