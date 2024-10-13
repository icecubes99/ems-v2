'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { z } from "zod";
import { superAdmin } from "./superAdmin";

export async function undoSalaryIncrease(salaryIncreaseEventId: string) {
    const user = await currentUser();

    if (!user) {
        return { error: "User not found" };
    }

    const superAdminResult = await superAdmin();
    if (superAdminResult.error) {
        return { error: superAdminResult.error };
    }


    try {
        await db.$transaction(async (tx) => {
            const salaryIncreaseEvent = await tx.salaryIncreaseEvent.findUnique({
                where: { id: salaryIncreaseEventId },
                include: {
                    department: {
                        include: {
                            designations: {
                                include: {
                                    AssignDesignation: {
                                        include: {
                                            user: {
                                                include: {
                                                    userSalary: true
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    },
                    designation: {
                        include: {
                            AssignDesignation: {
                                include: {
                                    user: {
                                        include: {
                                            userSalary: true
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
            });

            if (!salaryIncreaseEvent || salaryIncreaseEvent.isUndone) {
                throw new Error("Invalid or already undone salary increase event.");
            }

            if (!salaryIncreaseEvent.department && !salaryIncreaseEvent.designation) {
                throw new Error("Salary increase event is not associated with a department or designation.");
            }

            const isForDepartment = !!salaryIncreaseEvent.department;
            const targetEntity = isForDepartment ? salaryIncreaseEvent.department : salaryIncreaseEvent.designation;
            const entityType = isForDepartment ? "department" : "designation";

            const designations = isForDepartment ? targetEntity.designations : [targetEntity];

            for (const designation of designations) {
                let previousDesignationSalary: number;

                if (salaryIncreaseEvent.percentage) {
                    previousDesignationSalary = designation.designationSalary / (1 + salaryIncreaseEvent.percentage / 100);
                } else if (salaryIncreaseEvent.amount) {
                    previousDesignationSalary = designation.designationSalary - salaryIncreaseEvent.amount;
                } else {
                    throw new Error("Invalid salary increase event: neither percentage nor amount is set.");
                }

                await tx.designation.update({
                    where: { id: designation.id },
                    data: { designationSalary: previousDesignationSalary },
                });

                for (const assignedDesignation of designation.AssignDesignation) {
                    const employee = assignedDesignation.user;
                    if (employee.userSalary) {
                        const previousSalaryHistory = await tx.salaryHistory.findFirst({
                            where: {
                                userId: employee.id,
                            },
                            orderBy: { startDate: 'desc' },
                        });

                        if (previousSalaryHistory) {
                            await tx.salaryHistory.create({
                                data: {
                                    userId: employee.id,
                                    basicSalary: employee.userSalary.basicSalary,
                                    grossSalary: employee.userSalary.grossSalary || employee.userSalary.basicSalary,
                                    startDate: new Date(),
                                },
                            });

                            await tx.userSalary.update({
                                where: { id: employee.userSalary.id },
                                data: {
                                    grossSalary: previousSalaryHistory.grossSalary,
                                },
                            });
                        }
                    }
                }
            }

            await tx.salaryIncreaseEvent.update({
                where: { id: salaryIncreaseEventId },
                data: {
                    isUndone: true,
                    undoneAt: new Date(),
                    undoneBy: user.id,
                },
            });

            await tx.salaryIncreaseEvent.deleteMany({
                where: {
                    OR: [
                        { isUndone: true },
                        { isUndone: false }
                    ]
                }
            })

            await auditAction(user.id, `Undid salary increase for ${entityType} by Super Admin: ${user.name}`);
        });

        return { success: "Successfully undid salary increase" };
    } catch (error) {
        console.error("Error undoing salary increase:", error);
        return { error: "An error occurred while undoing the salary increase." };
    }
}