"use server";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { superAdmin } from "../superAdmin";
import { auditAction } from "@/actions/auditAction";

export async function removePayroll(payrollId: string) {
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

        const payroll = await db.payroll.findUnique({
            where: {
                id: payrollId
            },
            include: {
                payrollItems: {
                    include: {
                        deductions: true,
                        additionalEarningsArray: true
                    }
                }
            }
        })

        if (!payroll) {
            return { error: "Payroll not found!" }
        }
        const deductions = payroll?.payrollItems.map(item => item.deductions).flat();
        const additionalEarnings = payroll?.payrollItems.map(item => item.additionalEarningsArray).flat();

        if (deductions) {
            for (const deduction of deductions) {
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

        if (additionalEarnings) {
            for (const additionalEarning of additionalEarnings) {
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

        await db.payroll.delete({
            where: {
                id: payrollId
            }
        });

        const superaAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(dbUser.id, `Payroll Approved by: ${superaAdminName}`);

        return { success: "Payroll removed successfully!" };
    } catch (error) {
        console.error("Error removing payroll ", error);
        return { error: "Error removing payroll" };
    }
}