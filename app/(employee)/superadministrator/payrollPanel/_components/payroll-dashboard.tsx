"use client"

import { useState, useEffect } from 'react'
import { useApprovedDeniedPayroll } from '@/hooks/use-payroll-data'
import { usePayrollSummary, useDepartmentSalaries, useTopEarners, useYearlyPayrollData, usePayrollItems } from '@/hooks/use-data-dashboard'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { ChartContainer, ChartTooltip, ChartTooltipContent } from "@/components/ui/chart"
import { Bar, BarChart, Line, LineChart, Pie, PieChart, ResponsiveContainer, XAxis, YAxis } from "recharts"
import { Loader2, DollarSign, TrendingUp, Users, Calendar } from "lucide-react"
import HeadingCard from '@/components/heading-card'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { LeaveStatus } from '@prisma/client'

export function PayrollDashboard() {
    const [selectedPayrollId, setSelectedPayrollId] = useState<string | null>(null)
    const { payroll: pendingPayrolls, isLoading: isPendingPayrollLoading, error: pendingPayrollError } = useApprovedDeniedPayroll()
    const { payrollItems, isLoading: isPayrollItemsLoading, error: payrollItemsError } = usePayrollItems(selectedPayrollId || '')
    const { summary, isLoading: isSummaryLoading } = usePayrollSummary(selectedPayrollId || '')
    const { salaries: departmentSalaries, isLoading: isDepartmentSalariesLoading } = useDepartmentSalaries(selectedPayrollId || '')
    const { topEarners, isLoading: isTopEarnersLoading } = useTopEarners(selectedPayrollId || '')

    useEffect(() => {
        if (!selectedPayrollId && pendingPayrolls && pendingPayrolls.length > 0) {
            setSelectedPayrollId(pendingPayrolls[0].id)
        }
    }, [pendingPayrolls, selectedPayrollId])

    if (isPendingPayrollLoading || isPayrollItemsLoading || isSummaryLoading || isDepartmentSalariesLoading || isTopEarnersLoading) {
        return (
            <div className="flex items-center justify-center h-screen">
                <Loader2 className="h-8 w-8 animate-spin" />
            </div>
        )
    }

    if (pendingPayrollError || payrollItemsError) {
        return <div>Error loading data</div>
    }

    if (!pendingPayrolls || pendingPayrolls.length === 0) {
        return <div>No pending payrolls found</div>
    }

    const currentPayroll = pendingPayrolls.find(p => p.id === selectedPayrollId)

    // Prepare data for charts
    const salaryDistribution = payrollItems?.map(item => ({
        name: `${item.user.firstName} ${item.user.lastName}`,
        value: item.netSalary
    })) || []

    const deductionsVsEarnings = payrollItems?.map(item => ({
        name: `${item.user.firstName} ${item.user.lastName}`,
        deductions: item.totalDeductions,
        earnings: item.additionalEarnings
    })) || []

    const overtimeData = payrollItems?.map(item => {
        const firstName = item.user.firstName
            ? (item.user.firstName.length > 5
                ? `${item.user.firstName.charAt(0)}.`
                : item.user.firstName)
            : 'Unknown';

        const lastName = item.user.lastName
            ? (item.user.lastName.length > 7
                ? `${item.user.lastName.charAt(0)}.`
                : item.user.lastName)
            : 'Unknown';

        return {
            name: `${firstName} ${lastName}`,
            overtime: item.minutesOvertime
        };
    }) || [];

    const departmentSalaryData = departmentSalaries.map(dept => ({
        name: dept.departmentName,
        value: dept.totalSalary
    }))

    const topEarnersData = topEarners.map(earner => {
        const firstName = earner.user.firstName
            ? (earner.user.firstName.length > 5
                ? `${earner.user.firstName.charAt(0)}.`
                : earner.user.firstName)
            : 'Unknown';

        const lastName = earner.user.lastName
            ? (earner.user.lastName.length > 8
                ? `${earner.user.lastName.charAt(0)}.`
                : earner.user.lastName)
            : 'Unknown';

        return {
            name: `${firstName} ${lastName}`,
            salary: earner.netSalary
        };
    });

    const pesoFormatter = new Intl.NumberFormat('en-PH', {
        style: 'currency',
        currency: 'PHP',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
    });

    const chartColors = {
        purple: "rgba(147, 51, 234, 0.7)",
        red: "rgba(220, 38, 38, 0.7)",
        lightPurple: "rgba(167, 139, 250, 0.7)",
        lightRed: "rgba(248, 113, 113, 0.7)",
    }

    const payrollStatus = currentPayroll?.payrollStatus || 'Pending'
    const payrollId = currentPayroll?.id || 'N/A'

    const payrollLink = payrollStatus === LeaveStatus.APPROVED
        ? `/superadministrator/payrollPanel/payroll/approved/${payrollId}`
        : `/superadministrator/payrollPanel/payroll/pending/${payrollId}`;

    return (
        <div >
            <div className="mb-4 mt-5 flex justify-between items-center">
                <Select value={selectedPayrollId || undefined} onValueChange={(value) => setSelectedPayrollId(value)}>
                    <SelectTrigger className="w-[300px]">
                        <SelectValue placeholder="Select a pay period" />
                    </SelectTrigger>
                    <SelectContent>
                        {pendingPayrolls.map(payroll => (
                            <SelectItem key={payroll.id} value={payroll.id}>
                                {new Date(payroll.payPeriodStart).toDateString()} - {new Date(payroll.payPeriodEnd).toDateString()}
                            </SelectItem>
                        ))}
                    </SelectContent>
                </Select>
                <Link href={payrollLink}>
                    <Button variant={"auth"}>View Payroll</Button>
                </Link>
            </div>

            {currentPayroll && summary && (
                <>
                    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4 mb-4">
                        <HeadingCard
                            title='Total Payroll'
                            count={summary._sum.netSalary ? pesoFormatter.format(summary._sum.netSalary) : '₱0.00'}
                            icon={<DollarSign />}
                            subtitle={`For ${summary._count.id} employees`}
                            isLoading={isSummaryLoading}
                        />
                        <HeadingCard
                            title='Average Salary'
                            count={summary._avg.netSalary ? pesoFormatter.format(summary._avg.netSalary) : '₱0.00'}
                            icon={<TrendingUp />}
                            subtitle='Per employee'
                            isLoading={isSummaryLoading}
                        />
                        <HeadingCard
                            title='Total Deductions'
                            count={summary._sum.totalDeductions ? pesoFormatter.format(summary._sum.totalDeductions) : '₱0.00'}
                            icon={<Users />}
                            subtitle='Across all employees'
                            isLoading={isSummaryLoading}
                        />
                        <HeadingCard
                            title='Total Overtime'
                            count={summary._sum.overtimeSalary ? pesoFormatter.format(summary._sum.overtimeSalary) : '₱0.00'}
                            icon={<TrendingUp />}
                            subtitle='Overtime payments'
                            isLoading={isSummaryLoading}
                        />
                    </div>

                    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                        <Card>
                            <CardHeader>
                                <CardTitle>Salary Distribution</CardTitle>
                                <CardDescription>Net salary distribution among employees</CardDescription>
                            </CardHeader>
                            <CardContent className="h-[300px]">
                                <ChartContainer config={{}}>
                                    <ResponsiveContainer width="100%" height="100%">
                                        <PieChart>
                                            <Pie dataKey="value" data={salaryDistribution} fill={chartColors.purple} label />
                                            <ChartTooltip content={<ChartTooltipContent />} />
                                        </PieChart>
                                    </ResponsiveContainer>
                                </ChartContainer>
                            </CardContent>
                        </Card>

                        <Card>
                            <CardHeader>
                                <CardTitle>Deductions vs Additional Earnings</CardTitle>
                                <CardDescription>Comparison of deductions and additional earnings</CardDescription>
                            </CardHeader>
                            <CardContent className="h-[300px]">
                                <ChartContainer config={{}}>
                                    <ResponsiveContainer width="100%" height="100%">
                                        <BarChart data={deductionsVsEarnings}>
                                            <XAxis dataKey="name" />
                                            <YAxis />
                                            <Bar dataKey="deductions" fill={chartColors.red} />
                                            <Bar dataKey="earnings" fill={chartColors.purple} />
                                            <ChartTooltip content={<ChartTooltipContent />} />
                                        </BarChart>
                                    </ResponsiveContainer>
                                </ChartContainer>
                            </CardContent>
                        </Card>

                        <Card>
                            <CardHeader>
                                <CardTitle>Overtime Hours</CardTitle>
                                <CardDescription>Overtime minutes worked by employees</CardDescription>
                            </CardHeader>
                            <CardContent className="h-[300px]">
                                <ChartContainer config={{}}>
                                    <ResponsiveContainer width="100%" height="100%">
                                        <LineChart title='test' data={overtimeData}>
                                            <XAxis dataKey="name" />
                                            <YAxis />
                                            <Line type="monotone" dataKey="overtime" stroke={chartColors.purple} />
                                            <ChartTooltip content={<ChartTooltipContent />} />
                                        </LineChart>
                                    </ResponsiveContainer>
                                </ChartContainer>
                            </CardContent>
                        </Card>

                        <Card>
                            <CardHeader>
                                <CardTitle>Department Salaries</CardTitle>
                                <CardDescription>Total salaries by department</CardDescription>
                            </CardHeader>
                            <CardContent className="h-[300px]">
                                <ChartContainer config={{}}>
                                    <ResponsiveContainer width="100%" height="100%">
                                        <BarChart data={departmentSalaryData}>
                                            <XAxis dataKey="name" />
                                            <YAxis />
                                            <Bar dataKey="value" fill={chartColors.lightPurple} />
                                            <ChartTooltip content={<ChartTooltipContent />} />
                                        </BarChart>
                                    </ResponsiveContainer>
                                </ChartContainer>
                            </CardContent>
                        </Card>

                        <Card>
                            <CardHeader>
                                <CardTitle>Top Earners</CardTitle>
                                <CardDescription>Highest paid employees</CardDescription>
                            </CardHeader>
                            <CardContent className="h-[300px]">
                                <ChartContainer config={{}}>
                                    <ResponsiveContainer width="100%" height="100%">
                                        <BarChart data={topEarnersData} layout="vertical">
                                            <XAxis type="number" />
                                            <YAxis dataKey="name" type="category" />
                                            <Bar dataKey="salary" fill={chartColors.lightRed} />
                                            <ChartTooltip content={<ChartTooltipContent />} />
                                        </BarChart>
                                    </ResponsiveContainer>
                                </ChartContainer>
                            </CardContent>
                        </Card>
                    </div>

                    <Card className="mt-4">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <div className="space-y-1">
                                <CardTitle>Payroll Summary</CardTitle>
                                <CardDescription>
                                    Pay Period: {new Date(currentPayroll.payPeriodStart).toLocaleDateString()} - {new Date(currentPayroll.payPeriodEnd).toLocaleDateString()}
                                </CardDescription>
                            </div>
                            <Calendar className="h-4 w-4 text-muted-foreground" />
                        </CardHeader>
                        <CardContent>
                            <div className="grid gap-4 grid-cols-1 md:grid-cols-2">
                                <div className="space-y-2 border-r pr-3">
                                    <div className="flex justify-between">
                                        <span className="font-medium">Total Amount:</span>
                                        <span>{pesoFormatter.format(currentPayroll.totalAmount)}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="font-medium">Status:</span>
                                        <span>{currentPayroll.payrollStatus}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="font-medium">Number of Employees:</span>
                                        <span>{currentPayroll.payrollItems.length}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="font-medium">Total Basic Salary:</span>
                                        <span>{pesoFormatter.format(summary._sum.basicSalary || 0)}</span>
                                    </div>
                                </div>
                                <div className="space-y-2">
                                    <div className="flex justify-between">
                                        <span className="font-medium">Total Overtime:</span>
                                        <span>{pesoFormatter.format(summary._sum.overtimeSalary || 0)}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="font-medium">Total Additional Earnings:</span>
                                        <span>{pesoFormatter.format(summary._sum.additionalEarnings || 0)}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="font-medium">Total Deductions:</span>
                                        <span>{pesoFormatter.format(summary._sum.totalDeductions || 0)}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="font-medium">Net Payroll:</span>
                                        <span>{pesoFormatter.format(summary._sum.netSalary || 0)}</span>
                                    </div>
                                </div>
                            </div>
                        </CardContent>
                    </Card>
                </>
            )}
        </div>
    )
}

export function YearlyPayrollDashboard() {
    const currentYear = new Date().getFullYear();
    const [selectedYear, setSelectedYear] = useState(currentYear);
    const { yearlyData, isLoading, error } = useYearlyPayrollData(selectedYear);

    if (isLoading) {
        return (
            <div className="flex items-center justify-center h-screen">
                <Loader2 className="h-8 w-8 animate-spin" />
            </div>
        );
    }

    if (error) {
        return <div>Error loading data: {error}</div>;
    }

    if (!yearlyData) {
        return <div>No payroll data found for the selected year</div>;
    }

    const pesoFormatter = new Intl.NumberFormat('en-PH', {
        style: 'currency',
        currency: 'PHP',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
    });

    const chartColors = {
        purple: "rgba(147, 51, 234, 0.7)",
        red: "rgba(220, 38, 38, 0.7)",
        lightPurple: "rgba(167, 139, 250, 0.7)",
        lightRed: "rgba(248, 113, 113, 0.7)",
    };

    const monthlySalaryData = Object.values(yearlyData.monthlySummary).map(month => ({
        name: new Date(month.year, month.month - 1).toLocaleString('default', { month: 'short' }),
        totalSalary: month.totalSalary,
    }));

    const departmentSalaryData = Object.entries(yearlyData.departmentSalaries).map(([departmentName, totalSalary]) => ({
        name: departmentName,
        value: totalSalary,
    }));

    const topEarnersData = Object.values(yearlyData.employeeSalaries).map(earner => {
        const firstName = earner.user.firstName.length > 5
            ? `${earner.user.firstName.charAt(0)}.`
            : earner.user.firstName;
        const lastName = earner.user.lastName.length > 8
            ? `${earner.user.lastName.charAt(0)}.`
            : earner.user.lastName;
        return {
            name: `${firstName} ${lastName}`,
            salary: earner.totalSalary,
        };
    });

    return (
        <div className="mt-8 pt-8 border-t">
            <h1 className="text-3xl font-bold mb-4">Yearly Payroll Dashboard</h1>

            <div className="mb-4">
                <Select value={selectedYear.toString()} onValueChange={(value) => setSelectedYear(parseInt(value))}>
                    <SelectTrigger className="w-[200px]">
                        <SelectValue placeholder="Select a year" />
                    </SelectTrigger>
                    <SelectContent>
                        {[...Array(3)].map((_, i) => (
                            <SelectItem key={currentYear - i} value={(currentYear - i).toString()}>
                                {currentYear - i}
                            </SelectItem>
                        ))}
                    </SelectContent>
                </Select>
            </div>

            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4 mb-4">
                <HeadingCard
                    title='Total Yearly Payroll'
                    count={pesoFormatter.format(yearlyData.totalPayroll)}
                    icon={<DollarSign />}
                    subtitle={`For ${Object.keys(yearlyData.employeeSalaries).length} employees`}
                />
                <HeadingCard
                    title='Average Monthly Salary'
                    count={pesoFormatter.format(yearlyData.totalPayroll / 12)}
                    icon={<TrendingUp />}
                    subtitle='Per employee'
                />
                <HeadingCard
                    title='Total Yearly Deductions'
                    count={pesoFormatter.format(yearlyData.totalDeductions)}
                    icon={<Users />}
                    subtitle='Across all employees'
                />
                <HeadingCard
                    title='Total Yearly Overtime'
                    count={pesoFormatter.format(yearlyData.totalOvertimePay)}
                    icon={<TrendingUp />}
                    subtitle='Overtime payments'
                />
            </div>

            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                <Card>
                    <CardHeader>
                        <CardTitle>Monthly Salary Distribution</CardTitle>
                        <CardDescription>Total salary paid each month</CardDescription>
                    </CardHeader>
                    <CardContent className="h-[300px]">
                        <ChartContainer config={{}}>
                            <ResponsiveContainer width="100%" height="100%">
                                <BarChart data={monthlySalaryData}>
                                    <XAxis dataKey="name" />
                                    <YAxis />
                                    <Bar dataKey="totalSalary" fill={chartColors.purple} />
                                    <ChartTooltip content={<ChartTooltipContent />} />
                                </BarChart>
                            </ResponsiveContainer>
                        </ChartContainer>
                    </CardContent>
                </Card>

                <Card>
                    <CardHeader>
                        <CardTitle>Department Salaries</CardTitle>
                        <CardDescription>Total salaries by department</CardDescription>
                    </CardHeader>
                    <CardContent className="h-[300px]">
                        <ChartContainer config={{}}>
                            <ResponsiveContainer width="100%" height="100%">
                                <PieChart>
                                    <Pie dataKey="value" data={departmentSalaryData} fill={chartColors.lightPurple} label />
                                    <ChartTooltip content={<ChartTooltipContent />} />
                                </PieChart>
                            </ResponsiveContainer>
                        </ChartContainer>
                    </CardContent>
                </Card>

                <Card>
                    <CardHeader>
                        <CardTitle>Top Earners</CardTitle>
                        <CardDescription>Highest paid employees for the year</CardDescription>
                    </CardHeader>
                    <CardContent className="h-[300px]">
                        <ChartContainer config={{}}>
                            <ResponsiveContainer width="100%" height="100%">
                                <BarChart data={topEarnersData} layout="vertical">
                                    <XAxis type="number" />
                                    <YAxis dataKey="name" type="category" />
                                    <Bar dataKey="salary" fill={chartColors.lightRed} />
                                    <ChartTooltip content={<ChartTooltipContent />} />
                                </BarChart>
                            </ResponsiveContainer>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </div>

            <Card className="mt-4">
                <CardHeader className="flex flex-row items-center justify-between pb-2">
                    <div className="space-y-1">
                        <CardTitle>Yearly Payroll Summary</CardTitle>
                        <CardDescription>
                            Year: {selectedYear}
                        </CardDescription>
                    </div>
                    <Calendar className="h-4 w-4 text-muted-foreground" />
                </CardHeader>
                <CardContent>
                    <div className="grid gap-4 grid-cols-1 md:grid-cols-2">
                        <div className="space-y-2 border-r pr-3">
                            <div className="flex justify-between">
                                <span className="font-medium">Total Payroll:</span>
                                <span>{pesoFormatter.format(yearlyData.totalPayroll)}</span>
                            </div>
                            <div className="flex justify-between">
                                <span className="font-medium">Total Employees:</span>
                                <span>{Object.keys(yearlyData.employeeSalaries).length}</span>
                            </div>
                            <div className="flex justify-between">
                                <span className="font-medium">Average Monthly Salary:</span>
                                <span>{pesoFormatter.format(yearlyData.totalPayroll / 12)}</span>
                            </div>
                            <div className="flex justify-between">
                                <span className="font-medium">Total Basic Salary:</span>
                                <span>{pesoFormatter.format(yearlyData.totalBasicSalary)}</span>
                            </div>
                        </div>
                        <div className="space-y-2">
                            <div className="flex justify-between">
                                <span className="font-medium">Total Overtime Pay:</span>
                                <span>{pesoFormatter.format(yearlyData.totalOvertimePay)}</span>
                            </div>
                            <div className="flex justify-between">
                                <span className="font-medium">Total Additional Earnings:</span>
                                <span>{pesoFormatter.format(yearlyData.totalAdditionalEarnings)}</span>
                            </div>
                            <div className="flex justify-between">
                                <span className="font-medium">Total Deductions:</span>
                                <span>{pesoFormatter.format(yearlyData.totalDeductions)}</span>
                            </div>
                            <div className="flex justify-between">
                                <span className="font-medium">Net Payroll:</span>
                                <span>{pesoFormatter.format(yearlyData.totalPayroll)}</span>
                            </div>
                        </div>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}