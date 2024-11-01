'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { z } from "zod";
import { superAdmin } from "./superAdmin";
import { EditDesignationSalarySchema } from "@/schemas/payroll-index";

export async function editDesignationSalary(values: z.infer<typeof EditDesignationSalarySchema>) {
    const user = await currentUser();

    if (!user) {
        return { error: "User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }

    const validatedFields = EditDesignationSalarySchema.safeParse(values);

    if (!validatedFields.success) {
        return { error: "Invalid input." };
    }

    const { designationId, newSalary } = validatedFields.data;

    try {
        await db.$transaction(async (tx) => {
            const designation = await tx.designation.findUnique({
                where: { id: designationId },
                include: { AssignDesignation: { include: { user: { include: { userSalary: true } } } } },
            });

            if (!designation) {
                throw new Error(`Designation with ID ${designationId} not found`);
            }

            const salaryChangeEvent = await tx.salaryIncreaseEvent.create({
                data: {
                    amount: newSalary - designation.designationSalary,
                    appliedBy: user.id,
                    designations: {
                        create: [{ designation: { connect: { id: designationId } } }]
                    }
                },
            });

            await tx.designation.update({
                where: { id: designation.id },
                data: { designationSalary: newSalary },
            });

            for (const assignedDesignation of designation.AssignDesignation) {
                const employee = assignedDesignation.user;
                if (employee.userSalary) {
                    const previousBasicSalary = employee.userSalary.basicSalary;
                    const previousGrossSalary = employee.userSalary.grossSalary || employee.userSalary.basicSalary;
                    const newGrossSalary = previousGrossSalary + (newSalary - designation.designationSalary);
                    const amountChanged = newGrossSalary - previousGrossSalary;

                    await tx.salaryHistory.create({
                        data: {
                            userId: employee.id,
                            basicSalary: previousBasicSalary,
                            grossSalary: previousGrossSalary,
                            startDate: employee.userSalary.updatedAt,
                            amountIncreased: amountChanged,
                            salaryIncreaseEventId: salaryChangeEvent.id
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

            await auditAction(user.id, `Edited salary for designation ${designation.designationName} from $${designation.designationSalary} to $${newSalary} by Super Admin: ${user.name}`);
        });

        return { success: `Successfully updated salary for designation to $${newSalary}` };
    } catch (error) {
        console.error("Error editing designation salary:", error);
        return { error: "An error occurred while processing the salary edit." };
    }
}