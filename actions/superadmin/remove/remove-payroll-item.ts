"use server";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { superAdmin } from "../superAdmin";
import { auditAction } from "@/actions/auditAction";

export async function removeEmployeeFromPayroll(payrollId: string, userId: string) {
    try {
        const user = await currentUser();
        if (!user) {
            return { error: "Unauthorized!" };
        }

        const dbUser = await getUserById(user.id);
        if (!dbUser) {
            return { error: "User not found in database!" }
        }

        const superadminResult = await superAdmin();
        if (superadminResult.error) {
            return { error: superadminResult.error }
        }

        const payrollItem = await db.payrollItem.findFirst({
            where: {
                payrollId,
                userId
            },
            include: {
                deductions: true,
                additionalEarningsArray: true
            }
        });

        if (!payrollItem) {
            return { error: "Payroll item not found!" };
        }

        if (payrollItem.deductions) {
            for (const deduction of payrollItem.deductions) {
                await db.deductions.updateMany({
                    where: {
                        AND: [
                            { id: deduction.id },
                            { deductionType: { in: ["Disbursement", "Salary Advance", "Loan", "Others"] } }
                        ]
                    },
                    data: {
                        payrollItemId: null
                    }
                });
            }
        }

        if (payrollItem.additionalEarnings) {
            for (const additionalEarning of payrollItem.additionalEarningsArray) {
                await db.additionalEarnings.updateMany({
                    where: {
                        AND: [
                            { id: additionalEarning.id },
                            { earningType: { in: ["Bonus", "Others", "Reimbursement", "Allowance"] } }
                        ]
                    },
                    data: {
                        payrollItemId: null
                    }
                });
            }
        }

        await db.payroll.update({
            where: {
                id: payrollId
            },
            data: {
                totalAmount: {
                    decrement: payrollItem.netSalary
                }
            }
        })

        await db.payrollItem.delete({
            where: {
                id: payrollItem.id
            }
        });

        const superAdminName = user?.name || `${dbUser.firstName} ${dbUser.lastName}`;
        await auditAction(dbUser.id, `Removed employee ${userId} from payroll ${payrollId} by: ${superAdminName}`);

        return { success: "Employee removed from payroll successfully!" };
    } catch (error) {
        console.error("Error removing employee from payroll", error);
        return { error: "Error removing employee from payroll" };
    }
}