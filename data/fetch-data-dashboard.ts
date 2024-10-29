"use server"
interface Department {
    departmentName: string;
}

interface User {
    firstName: string;
    lastName: string;
    department: Department;
}

interface PayrollItem {
    userId: string;
    netSalary: number;
    basicSalary: number;
    overtimeSalary: number;
    additionalEarnings: number;
    totalDeductions: number;
    user: User;
}

interface Payroll {
    payPeriodStart: Date;
    payrollItems: PayrollItem[];
}

interface AggregatedData {
    totalPayroll: number;
    totalBasicSalary: number;
    totalOvertimePay: number;
    totalAdditionalEarnings: number;
    totalDeductions: number;
    monthlySummary: Record<string, { year: number; month: number; totalSalary: number }>;
    departmentSalaries: Record<string, number>;
    employeeSalaries: Record<string, { user: { firstName: string; lastName: string }; totalSalary: number }>;
}
import { db } from "@/lib/db"

export async function fetchPayrollSummary(payrollId: string) {
    const summary = await db.payrollItem.aggregate({
        where: { payrollId },
        _sum: {
            basicSalary: true,
            overtimeSalary: true,
            additionalEarnings: true,
            totalDeductions: true,
            netSalary: true,
        },
        _avg: {
            netSalary: true,
        },
        _count: { id: true },
    })

    return summary
}

export async function fetchDepartmentSalaries(payrollId: string) {
    const departmentSalaries = await db.payrollItem.groupBy({
        by: ['userId'],
        where: { payrollId },
        _sum: { netSalary: true },
    })

    const departmentTotals = await Promise.all(
        departmentSalaries.map(async (item) => {
            const user = await db.user.findUnique({
                where: { id: item.userId },
                include: { department: true },
            })
            return {
                departmentName: user?.department?.departmentName || 'Unassigned',
                totalSalary: item._sum.netSalary || 0,
            }
        })
    )

    return departmentTotals.reduce((acc, curr) => {
        const existing = acc.find(item => item.departmentName === curr.departmentName)
        if (existing) {
            existing.totalSalary += curr.totalSalary
        } else {
            acc.push(curr)
        }
        return acc
    }, [] as { departmentName: string, totalSalary: number }[])
}

export async function fetchTopEarners(payrollId: string, limit: number = 5) {
    const topEarners = await db.payrollItem.findMany({
        where: { payrollId },
        select: {
            user: { select: { firstName: true, lastName: true } },
            netSalary: true,
        },
        orderBy: { netSalary: 'desc' },
        take: limit,
    })

    return topEarners
}


export async function fetchYearlyPayrollData(year: number): Promise<AggregatedData> {
    const yearlyData = await db.payroll.findMany({
        where: {
            payPeriodStart: {
                gte: new Date(`${year}-01-01`),
                lt: new Date(`${year + 1}-01-01`),
            },
        },
        include: {
            payrollItems: {
                include: {
                    user: {
                        select: {
                            firstName: true,
                            lastName: true,
                            department: {
                                select: {
                                    departmentName: true,
                                },
                            },
                        },
                    },
                },
            },
        },
    });

    const aggregatedData: AggregatedData = yearlyData.reduce((acc, payroll) => {
        payroll.payrollItems.forEach(item => {
            acc.totalPayroll += item.netSalary;
            acc.totalBasicSalary += item.basicSalary;
            acc.totalOvertimePay += item.overtimeSalary;
            acc.totalAdditionalEarnings += item.additionalEarnings;
            acc.totalDeductions += item.totalDeductions;

            const monthKey = `${payroll.payPeriodStart.getFullYear()}-${payroll.payPeriodStart.getMonth() + 1}`;
            if (!acc.monthlySummary[monthKey]) {
                acc.monthlySummary[monthKey] = {
                    year: payroll.payPeriodStart.getFullYear(),
                    month: payroll.payPeriodStart.getMonth() + 1,
                    totalSalary: 0,
                };
            }
            acc.monthlySummary[monthKey].totalSalary += item.netSalary;

            const departmentName = item.user.department?.departmentName || 'Unknown';
            if (!acc.departmentSalaries[departmentName]) {
                acc.departmentSalaries[departmentName] = 0;
            }
            acc.departmentSalaries[departmentName] += item.netSalary;

            if (!acc.employeeSalaries[item.userId]) {
                acc.employeeSalaries[item.userId] = {
                    user: {
                        firstName: item.user.firstName || "Test FirstName",
                        lastName: item.user.lastName || "Test LastName",
                    },
                    totalSalary: 0,
                };
            }
            acc.employeeSalaries[item.userId].totalSalary += item.netSalary;
        });
        return acc;
    }, {
        totalPayroll: 0,
        totalBasicSalary: 0,
        totalOvertimePay: 0,
        totalAdditionalEarnings: 0,
        totalDeductions: 0,
        monthlySummary: {},
        departmentSalaries: {},
        employeeSalaries: {},
    } as AggregatedData);

    return aggregatedData;
}