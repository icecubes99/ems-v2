'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { z } from "zod";
import { superAdmin } from "./superAdmin";
import { EditUserBaseSalarySchema } from "@/schemas/payroll-index";

export async function editUserBaseSalary(values: z.infer<typeof EditUserBaseSalarySchema>) {
    const currentUserSession = await currentUser();

    if (!currentUserSession) {
        return { error: "User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    const validatedFields = EditUserBaseSalarySchema.safeParse(values);

    if (!validatedFields.success) {
        return { error: "Invalid input." };
    }

    const { newBaseSalary, userId } = validatedFields.data;

    try {
        await db.$transaction(async (tx) => {
            // Get current user salary info
            const userSalary = await tx.userSalary.findUnique({
                where: { userId },
                include: {
                    user: {
                        include: {
                            assignedDesignations: {
                                include: {
                                    designation: true
                                }
                            }
                        }
                    }
                }
            });

            if (!userSalary) {
                throw new Error(`User salary record for ID ${userId} not found`);
            }

            const previousBasicSalary = userSalary.basicSalary;
            const previousGrossSalary = userSalary.grossSalary || previousBasicSalary;

            // Calculate new gross salary by adding designation salary if exists
            const designationSalary = userSalary.user.assignedDesignations?.designation?.designationSalary || 0;
            const newGrossSalary = newBaseSalary + designationSalary;

            // Create salary change event
            const salaryChangeEvent = await tx.salaryIncreaseEvent.create({
                data: {
                    amount: newBaseSalary - previousBasicSalary,
                    appliedBy: currentUserSession.id
                }
            });

            // Create salary history record
            await tx.salaryHistory.create({
                data: {
                    userId,
                    basicSalary: previousBasicSalary,
                    grossSalary: previousGrossSalary,
                    startDate: userSalary.updatedAt,
                    amountIncreased: newBaseSalary - previousBasicSalary,
                    salaryIncreaseEventId: salaryChangeEvent.id
                }
            });

            // Update user salary
            await tx.userSalary.update({
                where: { userId },
                data: {
                    basicSalary: newBaseSalary,
                    grossSalary: newGrossSalary
                }
            });

            // Audit the change
            await auditAction(
                currentUserSession.id,
                `Base salary edited for user ${userId} from ${previousBasicSalary} to ${newBaseSalary} by SuperAdmin: ${currentUserSession.name}`
            );
        });

        return { success: "Successfully updated the base salary of employee" };
    } catch (error) {
        console.error('Failed to Edit Base Salary of User:', error);
        return { error: "Failed to Edit Base Salary of User" };
    }
}