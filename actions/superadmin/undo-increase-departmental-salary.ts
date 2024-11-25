'use server'

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
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
                    departments: {
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
                            }
                        }
                    },
                    designations: {
                        include: {
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
                        }
                    }
                },
            });

            if (!salaryIncreaseEvent || salaryIncreaseEvent.isUndone) {
                throw new Error("Invalid or already undone salary increase event.");
            }

            if (salaryIncreaseEvent.departments.length === 0 && salaryIncreaseEvent.designations.length === 0) {
                throw new Error("Salary increase event is not associated with any departments or designations.");
            }

            // Handle departments with the new function
            for (const deptIncrease of salaryIncreaseEvent.departments) {
                await undoDepartmentSalaryIncrease(tx, deptIncrease.department, salaryIncreaseEvent);
            }


            // Handle designations
            for (const desigIncrease of salaryIncreaseEvent.designations) {
                const designation = desigIncrease.designation;
                await undoDesignationSalaryIncrease(tx, designation, salaryIncreaseEvent);
            }

            await tx.salaryIncreaseEvent.update({
                where: { id: salaryIncreaseEventId },
                data: {
                    isUndone: true,
                    undoneAt: new Date(),
                    undoneBy: user.id,
                },
            });

            await auditAction(user.id, `Undid salary increase for multiple departments/designations by Super Admin: ${user.name}`);
        });

        return { success: "Successfully undid salary increase" };
    } catch (error) {
        console.error("Error undoing salary increase:", error);
        return { error: "An error occurred while undoing the salary increase." };
    }
}

async function undoDesignationSalaryIncrease(tx: any, designation: any, salaryIncreaseEvent: any) {
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
                    salaryIncreaseEventId: salaryIncreaseEvent.id
                },
                orderBy: { startDate: 'desc' },
            });

            if (previousSalaryHistory) {
                await tx.salaryHistory.create({
                    data: {
                        userId: employee.id,
                        basicSalary: employee.userSalary.basicSalary,
                        grossSalary: employee.userSalary.grossSalary,
                        startDate: new Date(),
                        amountIncreased: -previousSalaryHistory.amountIncreased,
                        salaryIncreaseEventId: salaryIncreaseEvent.id
                    },
                });

                await tx.userSalary.update({
                    where: { id: employee.userSalary.id },
                    data: {
                        grossSalary: employee.userSalary.grossSalary - previousSalaryHistory.amountIncreased,
                    },
                });
            }
        }
    }
}

// Add new helper function
async function undoDepartmentSalaryIncrease(tx: any, department: any, salaryIncreaseEvent: any) {
    // Create salary history entries for department changes
    const departmentDesignations = department.designations;

    for (const designation of departmentDesignations) {
        let previousDesignationSalary: number;

        if (salaryIncreaseEvent.percentage) {
            previousDesignationSalary = designation.designationSalary / (1 + salaryIncreaseEvent.percentage / 100);
        } else if (salaryIncreaseEvent.amount) {
            previousDesignationSalary = designation.designationSalary - salaryIncreaseEvent.amount;
        } else {
            throw new Error("Invalid salary increase event: neither percentage nor amount is set.");
        }

        // Create history entries for each employee in the department
        for (const assignedDesignation of designation.AssignDesignation) {
            const employee = assignedDesignation.user;
            if (employee.userSalary) {
                const previousSalaryHistory = await tx.salaryHistory.findFirst({
                    where: {
                        userId: employee.id,
                        salaryIncreaseEventId: salaryIncreaseEvent.id
                    },
                    orderBy: { startDate: 'desc' },
                });

                if (previousSalaryHistory) {
                    // Record the reversal in salary history
                    await tx.salaryHistory.create({
                        data: {
                            userId: employee.id,
                            basicSalary: employee.userSalary.basicSalary,
                            grossSalary: employee.userSalary.grossSalary,
                            startDate: new Date(),
                            amountIncreased: -previousSalaryHistory.amountIncreased,
                            salaryIncreaseEventId: salaryIncreaseEvent.id
                        },
                    });

                    // Update the actual salary
                    await tx.userSalary.update({
                        where: { id: employee.userSalary.id },
                        data: {
                            grossSalary: employee.userSalary.grossSalary - previousSalaryHistory.amountIncreased,
                        },
                    });
                }
            }
        }

        // Update the designation salary
        await tx.designation.update({
            where: { id: designation.id },
            data: { designationSalary: previousDesignationSalary },
        });
    }
}
