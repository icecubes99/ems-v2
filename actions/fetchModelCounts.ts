"use server"

import { db } from "@/lib/db"

export async function fetchUsersCount() {
    try {
        const userCount = await db.user.count({})
        return userCount
    } catch (error) {
        console.error("Error fetching user count: ", error);
        throw new Error("Failed to fetch Users Count")
    }
}

export async function fetchDepartmentsCount() {
    try {
        const departmentCount = await db.department.count({})
        return departmentCount
    } catch (error) {
        console.error("Error fetching department count: ", error);
        throw new Error("Failed to fetch Department Count")
    }
}

export async function fetchDesignationsCount() {
    try {
        const designationCount = await db.designation.count({})
        return designationCount
    } catch (error) {
        console.error("Error fetching designation count: ", error);
        throw new Error("Failed to fetch Designation Count")
    }
}

export async function fetchOvertimesPendingCount() {
    try {
        const pendingOvertimesCount = await db.overtimes.count({
            where: {
                status: "PENDING"
            }
        })
        return pendingOvertimesCount
    } catch (error) {
        console.error("Error fetching pending overtimes count: ", error);
        throw new Error("Failed to fetch Pending Overtimes Count")
    }
}

export async function fetchLeavesPendingCount() {
    try {
        const pendingLeavesCount = await db.leaves.count({
            where: {
                leaveStatus: "PENDING"
            }
        })
        return pendingLeavesCount
    } catch (error) {
        console.error("Error fetching pending leaves count: ", error);
        throw new Error("Failed to fetch Pending Leaves Count")
    }
}

export async function fetchActiveUsersCount() {
    try {
        const userCount = await db.user.count({
            where: {
                assignedDesignations: {
                    status: "ACTIVE"
                }
            }
        })
        return userCount
    } catch (error) {
        console.error("Error fetching user count: ", error);
        throw new Error("Failed to fetch Users Count")
    }
}
export async function fetchInactiveUsersCount() {
    try {
        const userCount = await db.user.count({
            where: {
                OR: [
                    {
                        assignedDesignations: null
                    },
                    {
                        assignedDesignations: {
                            status: "INACTIVE"
                        }
                    }
                ]
            }
        });
        return userCount;
    } catch (error) {
        console.error("Error fetching user count: ", error);
        throw new Error("Failed to fetch Users Count");
    }
}

export async function fetchUserPayslipCount(userId: string) {
    try {
        const payslipCount = await db.payrollItem.count({
            where: {
                userId: userId
            }
        })
        return payslipCount
    } catch (error) {
        console.error("Error fetching user payslip count: ", error);
        throw new Error("Failed to fetch User Payslip Count")
    }
}

export async function fetchUserBasicSalary(userId: string) {
    try {
        const basicSalary = await db.userSalary.findFirst({
            where: {
                userId: userId
            }
        })
        return basicSalary?.grossSalary
    } catch (error) {
        console.error("Error fetching user basic salary: ", error);
        throw new Error("Failed to fetch User Basic Salary")
    }
}

export async function fetchTotalPayrollCount() {
    try {
        const payrollCount = await db.payroll.count({})
        return payrollCount
    } catch (error) {
        console.error("Error fetching payroll count: ", error);
        throw new Error("Failed to fetch Payroll Count")
    }
}

export async function fetchApprovedPayrollCount() {
    try {
        const payrollCount = await db.payroll.count({
            where: {
                payrollStatus: "APPROVED"
            }
        })
        return payrollCount
    } catch (error) {
        console.error("Error fetching payroll count: ", error);
        throw new Error("Failed to fetch Payroll Count")
    }
}

export async function fetchRejectedPayrollCount() {
    try {
        const payrollCount = await db.payroll.count({
            where: {
                payrollStatus: "REJECTED"
            }
        })
        return payrollCount
    } catch (error) {
        console.error("Error fetching payroll count: ", error);
        throw new Error("Failed to fetch Payroll Count")
    }
}

export async function fetchTotalPayslipCount() {
    try {
        const payslipCount = await db.payrollItem.count({
            where: {
                payroll: {
                    payrollStatus: "APPROVED"
                }
            }
        })
        return payslipCount
    } catch (error) {
        console.error("Error fetching payslip count: ", error);
        throw new Error("Failed to fetch Payslip Count")
    }
}

export async function fetchTotalAuditLogs() {
    try {
        const auditLogCounts = await db.auditLog.count({})
        return auditLogCounts
    } catch (error) {
        console.error("Error fetching audit logs count: ", error);
        throw new Error("Failed to fetch Audit Logs Count")
    }
}