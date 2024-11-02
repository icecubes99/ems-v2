"use server";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { superAdmin } from "../superAdmin";
import { auditAction } from "@/actions/auditAction";
import { archiveEntity } from "./archive-entity";
import { ArchiveType } from "@prisma/client";

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
                        additionalEarningsArray: true,
                        daysNotWorkedArray: true,
                        timesheets: true
                    }
                }
            }
        })

        if (!payroll) {
            return { error: "Payroll not found!" }
        }

        await archiveEntity(ArchiveType.PAYROLL, payrollId, {
            ...payroll,
            payrollItems: payroll.payrollItems.map(item => ({
                ...item,
                deductions: item.deductions,
                additionalEarnings: item.additionalEarningsArray,
                daysNotWorked: item.daysNotWorkedArray,
                timesheets: item.timesheets
            }))
        });

        await db.$transaction(async (prisma) => {
            // Update timesheets to remove payrollItemId
            await prisma.timesheet.updateMany({
                where: {
                    payrollItemId: { in: payroll.payrollItems.map(item => item.id) }
                },
                data: {
                    payrollItemId: null
                }
            });

            // Update deductions
            await prisma.deductions.updateMany({
                where: {
                    payrollItemId: { in: payroll.payrollItems.map(item => item.id) },
                    deductionType: { in: ["Disbursement", "Salary Advance", "Loan", "Others"] }
                },
                data: {
                    payrollItemId: null
                }
            });

            // Update additional earnings
            await prisma.additionalEarnings.updateMany({
                where: {
                    payrollItemId: { in: payroll.payrollItems.map(item => item.id) },
                    earningType: { in: ["Bonus", "Others", "Reimbursement", "Allowance"] }
                },
                data: {
                    payrollItemId: null
                }
            });

            // Delete the payroll and its items
            await prisma.payroll.delete({
                where: { id: payrollId }
            });
        });

        const superaAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(dbUser.id, `Payroll Approved by: ${superaAdminName}`);

        return { success: "Payroll removed successfully!" };
    } catch (error) {
        console.error("Error removing payroll ", error);
        return { error: "Error removing payroll" };
    }
}