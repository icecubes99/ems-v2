'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { z } from "zod";
import { superAdmin } from "./superAdmin";
import { IncreaseDesignationSalarySchema } from "@/schemas/payroll-index";

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
                        await tx.salaryHistory.create({
                            data: {
                                userId: employee.id,
                                basicSalary: employee.userSalary.basicSalary,
                                grossSalary: employee.userSalary.grossSalary || employee.userSalary.basicSalary,
                                startDate: employee.userSalary.updatedAt,
                            },
                        });

                        const newBasicSalary = employee.userSalary.basicSalary
                        const newGrossSalary = newBasicSalary + newDesignationSalary;

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