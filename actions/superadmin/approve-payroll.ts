"use server"
import { db } from "@/lib/db";
import { getUserById } from "@/data/user";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { superAdmin } from "./superAdmin";
import { UserRole } from "@prisma/client";


export const approvePayroll = async (payrollId: string) => {
    try {
        const user = await currentUser();
        if (!user) {
            return { error: "Unauthorized!" };
        }

        const dbUser = await getUserById(user?.id);
        if (!dbUser) {
            return { error: "User not found in database!" };
        }

        const superAdminResult = await superAdmin();
        if (superAdminResult.error) {
            return { error: superAdminResult.error };
        }

        const superaAdminName = user?.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(dbUser.id, `Payroll Approved by: ${superaAdminName}`);

        await db.payroll.update({
            where: { id: payrollId },
            data: { payrollStatus: "APPROVED" }
        });

        return { success: "Payroll approved successfully!" };
    } catch (error) {
        console.error("Failed to approve Payroll", error);
        return { error: "Failed to approve payroll!" };
    }
}