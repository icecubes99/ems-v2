'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { z } from "zod";
import { superAdmin } from "./superAdmin";
import { IncreaseDepartmentSalarySchema } from "@/schemas/payroll-index";

export async function increaseDepartmentSalary(values: z.infer<typeof IncreaseDepartmentSalarySchema>) {
    const user = await currentUser();

    if (!user) {
        return { error: "User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    const validatedFields = IncreaseDepartmentSalarySchema.safeParse(values);

    if (!validatedFields.success) {
        return { error: "Invalid input." };
    }

    const { departmentIds, increaseType, value } = validatedFields.data;

    try {
        await db.$transaction(async (tx) => {
            const salaryIncreaseEvent = await tx.salaryIncreaseEvent.create({
                data: {
                    percentage: increaseType === 'percentage' ? value : null,
                    amount: increaseType === 'amount' ? value : null,
                    appliedBy: user.id,
                    departments: {
                        create: departmentIds.map(departmentId => ({
                            department: { connect: { id: departmentId } }
                        }))
                    }
                },
            });

            for (const departmentId of departmentIds) {
                const department = await tx.department.findUnique({
                    where: { id: departmentId },
                    include: { designations: { include: { AssignDesignation: { include: { user: { include: { userSalary: true } } } } } } },
                });

                if (!department) {
                    throw new Error(`Department with ID ${departmentId} not found`);
                }

                for (const designation of department.designations) {
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
            }

            const increaseDescription = increaseType === 'percentage' ? `${value}%` : `$${value}`;
            await auditAction(user.id, `Increased salaries for departments ${departmentIds.join(', ')} by ${increaseDescription} by Super Admin: ${user.name}`);
        });

        const increaseDescription = increaseType === 'percentage' ? `${value}%` : `$${value}`;
        return { success: `Successfully increased salaries for selected departments by ${increaseDescription}` };
    } catch (error) {
        console.error("Error increasing department salary:", error);
        return { error: "An error occurred while processing the salary increase." };
    }
}