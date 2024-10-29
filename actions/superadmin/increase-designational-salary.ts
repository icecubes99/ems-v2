'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { z } from "zod";
import { superAdmin } from "./superAdmin";
import { DecreaseDesignationSalarySchema, IncreaseDesignationSalarySchema } from "@/schemas/payroll-index";

export async function increaseDesignationSalary(values: z.infer<typeof IncreaseDesignationSalarySchema>) {
    const user = await currentUser();

    if (!user) {
        return { error: "User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    const validatedFields = IncreaseDesignationSalarySchema.safeParse(values);

    if (!validatedFields.success) {
        return { error: "Invalid input." };
    }

    const { designationIds, increaseType, value } = validatedFields.data;

    try {
        await db.$transaction(async (tx) => {
            const salaryIncreaseEvent = await tx.salaryIncreaseEvent.create({
                data: {
                    percentage: increaseType === 'percentage' ? value : null,
                    amount: increaseType === 'amount' ? value : null,
                    appliedBy: user.id,
                    designations: {
                        create: designationIds.map(designationId => ({
                            designation: { connect: { id: designationId } }
                        }))
                    }
                },
            });

            for (const designationId of designationIds) {
                const designation = await tx.designation.findUnique({
                    where: { id: designationId },
                    include: { AssignDesignation: { include: { user: { include: { userSalary: true } } } } },
                });

                if (!designation) {
                    throw new Error(`Designation with ID ${designationId} not found`);
                }

                let newDesignationSalary: number;
                if (increaseType === 'percentage') {
                    newDesignationSalary = designation.designationSalary * (1 + value / 100);
                } else {
                    newDesignationSalary = designation.designationSalary + value;
                }

                await tx.designation.update({
                    where: { id: designation.id },
                    data: { designationSalary: newDesignationSalary },
                });

                for (const assignedDesignation of designation.AssignDesignation) {
                    const employee = assignedDesignation.user;
                    if (employee.userSalary) {
                        const previousBasicSalary = employee.userSalary.basicSalary;
                        const previousGrossSalary = employee.userSalary.grossSalary || employee.userSalary.basicSalary;
                        const newGrossSalary = previousGrossSalary + (newDesignationSalary - designation.designationSalary);
                        const amountIncreased = newGrossSalary - previousGrossSalary;

                        await tx.salaryHistory.create({
                            data: {
                                userId: employee.id,
                                basicSalary: previousBasicSalary,
                                grossSalary: previousGrossSalary,
                                startDate: employee.userSalary.updatedAt,
                                amountIncreased: amountIncreased,
                                salaryIncreaseEventId: salaryIncreaseEvent.id
                            },
                        });

                        await tx.userSalary.update({
                            where: { id: employee.userSalary.id },
                            data: {
                                grossSalary: newGrossSalary,
                            },
                        });
                    }
                }
            }

            const increaseDescription = increaseType === 'percentage' ? `${value}%` : `$${value}`;
            await auditAction(user.id, `Increased salaries for designations ${designationIds.join(', ')} by ${increaseDescription} by Super Admin: ${user.name}`);
        });

        const increaseDescription = increaseType === 'percentage' ? `${value}%` : `$${value}`;
        return { success: `Successfully increased salaries for selected designations by ${increaseDescription}` };
    } catch (error) {
        console.error("Error increasing designation salary:", error);
        return { error: "An error occurred while processing the salary increase." };
    }
}

export async function decreaseDesignationSalary(values: z.infer<typeof DecreaseDesignationSalarySchema>) {
    const user = await currentUser();

    if (!user) {
        return { error: "User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    const validatedFields = DecreaseDesignationSalarySchema.safeParse(values);

    if (!validatedFields.success) {
        return { error: "Invalid input." };
    }

    const { designationIds, decreaseType, value } = validatedFields.data;

    try {
        let errorMessage: string | null = null;

        await db.$transaction(async (tx) => {
            // Check if the decrease is valid for all designations
            for (const designationId of designationIds) {
                const designation = await tx.designation.findUnique({
                    where: { id: designationId },
                });

                if (!designation) {
                    errorMessage = `Designation with ID ${designationId} not found`;
                    return; // Exit the transaction
                }

                let newDesignationSalary: number;
                if (decreaseType === 'percentage') {
                    newDesignationSalary = designation.designationSalary * (1 - value / 100);
                } else {
                    newDesignationSalary = designation.designationSalary - value;
                }

                if (newDesignationSalary < 0) {
                    errorMessage = `Salary decrease is greater than the designation salary for ${designation.designationName}`;
                    return; // Exit the transaction
                }
            }

            if (errorMessage) {
                return;
            }

            const salaryDecreaseEvent = await tx.salaryIncreaseEvent.create({
                data: {
                    percentage: decreaseType === 'percentage' ? -value : null,
                    amount: decreaseType === 'amount' ? -value : null,
                    appliedBy: user.id,
                    designations: {
                        create: designationIds.map(designationId => ({
                            designation: { connect: { id: designationId } }
                        }))
                    }
                },
            });

            for (const designationId of designationIds) {
                const designation = await tx.designation.findUnique({
                    where: { id: designationId },
                    include: { AssignDesignation: { include: { user: { include: { userSalary: true } } } } },
                });

                if (!designation) {
                    throw new Error(`Designation with ID ${designationId} not found`);
                }

                let newDesignationSalary: number;
                if (decreaseType === 'percentage') {
                    newDesignationSalary = designation.designationSalary * (1 - value / 100);
                } else {
                    newDesignationSalary = designation.designationSalary - value;
                }

                await tx.designation.update({
                    where: { id: designation.id },
                    data: { designationSalary: newDesignationSalary },
                });

                for (const assignedDesignation of designation.AssignDesignation) {
                    const employee = assignedDesignation.user;
                    if (employee.userSalary) {
                        const previousBasicSalary = employee.userSalary.basicSalary;
                        const previousGrossSalary = employee.userSalary.grossSalary || employee.userSalary.basicSalary;
                        const newGrossSalary = previousGrossSalary - (designation.designationSalary - newDesignationSalary);
                        const amountDecreased = previousGrossSalary - newGrossSalary;

                        await tx.salaryHistory.create({
                            data: {
                                userId: employee.id,
                                basicSalary: previousBasicSalary,
                                grossSalary: previousGrossSalary,
                                startDate: employee.userSalary.updatedAt,
                                amountIncreased: -amountDecreased,
                                salaryIncreaseEventId: salaryDecreaseEvent.id
                            },
                        });

                        await tx.userSalary.update({
                            where: { id: employee.userSalary.id },
                            data: {
                                grossSalary: newGrossSalary,
                            },
                        });
                    }
                }
            }

            const decreaseDescription = decreaseType === 'percentage' ? `${value}%` : `$${value}`;
            await auditAction(user.id, `Decreased salaries for designations ${designationIds.join(', ')} by ${decreaseDescription} by Super Admin: ${user.name}`);
        });

        if (errorMessage) {
            return { error: errorMessage };
        }

        const decreaseDescription = decreaseType === 'percentage' ? `${value}%` : `$${value}`;
        return { success: `Successfully decreased salaries for selected designations by ${decreaseDescription}` };
    } catch (error) {
        console.error("Error decreasing designation salary:", error);
        return { error: "An error occurred while processing the salary decrease." };
    }
}