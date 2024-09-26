"use client"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Briefcase, Building, CalendarClock, UserCheck, UserPlus, Users, UserX } from "lucide-react"
import { useTotalActiveUserCount, useTotalDepartmentsCount, useTotalDesignationCount, useTotalInactiveUserCount, useTotalUserCount, useUserBasicSalary, useUserPayslip } from "@/hooks/use-ModelCounts"
import Link from "next/link"
import { useCurrentUserId } from "@/hooks/use-current-user"
import { FaMoneyBillWave } from "react-icons/fa"
import { IoDocumentAttachSharp } from "react-icons/io5"
import { FcMoneyTransfer } from "react-icons/fc"

const PayslipCards = () => {
    const formatter = new Intl.NumberFormat('en-PH', {
        style: 'currency',
        currency: 'PHP',
    });

    const userId = useCurrentUserId();
    const { payslipCount } = useUserPayslip(userId as string);
    const { basicSalary } = useUserBasicSalary(userId as string);

    return (
        <>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-3 mt-5 mr-6 ">
                <Card className="hover:shadow-xl transition-shadow duration-300">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Total Payslips Received
                        </CardTitle>
                        <FaMoneyBillWave className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{payslipCount}</div>
                    </CardContent>
                </Card>

                <Card className="hover:shadow-xl transition-shadow duration-300">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Basic Semi-Monthly Salary
                        </CardTitle>
                        <FcMoneyTransfer className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{formatter.format(basicSalary || 0)}</div>
                    </CardContent>
                </Card>

            </div>
        </>
    )
}

export default PayslipCards