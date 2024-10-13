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

    const { departmentId, increaseType, value } = validatedFields.data;

    try {
        await db.$transaction(async (tx) => {
            const department = await tx.department.findUnique({
                where: { id: departmentId },
                include: { designations: { include: { AssignDesignation: { include: { user: { include: { userSalary: true } } } } } } },
            });

            if (!department) {
                throw new Error("Department not found");
            }

            // Check if tx.salaryIncreaseEvent exists before calling create
            if (!tx.salaryIncreaseEvent) {
                throw new Error("SalaryIncreaseEvent is not defined in the transaction");
            }

            await tx.salaryIncreaseEvent.create({
                data: {
                    departmentId,
                    percentage: increaseType === 'percentage' ? value : null,
                    amount: increaseType === 'amount' ? value : null,
                    appliedBy: user.id,
                },
            });

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
            await auditAction(user.id, `Increased salaries for department ${departmentId} by ${increaseDescription} by Super Admin: ${user.name}`);
        });

        const increaseDescription = increaseType === 'percentage' ? `${value}%` : `$${value}`;
        return { success: `Successfully increased salaries for department by ${increaseDescription}` };
    } catch (error) {
        console.error("Error increasing department salary:", error);
        return { error: "An error occurred while processing the salary increase." };
    }
}