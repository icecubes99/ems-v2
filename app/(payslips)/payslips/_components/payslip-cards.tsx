"use client"
import HeadingCard from "@/components/heading-card"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { useTotalActiveUserCount, useTotalDepartmentsCount, useTotalDesignationCount, useTotalInactiveUserCount, useTotalUserCount, useUserBasicSalary, useUserPayslip } from "@/hooks/use-ModelCounts"
import { useCurrentUserId } from "@/hooks/use-current-user"
import { FaMoneyBillWave } from "react-icons/fa"
import { FcMoneyTransfer } from "react-icons/fc"

const PayslipCards = () => {
    const formatter = new Intl.NumberFormat('en-PH', {
        style: 'currency',
        currency: 'PHP',
    });

    const userId = useCurrentUserId();
    const { payslipCount, isLoading } = useUserPayslip(userId as string);
    const { basicSalary, isLoading: bsLoad } = useUserBasicSalary(userId as string);

    return (
        <>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-3 mt-5   ">
                <HeadingCard title='Total Payslips Received' count={payslipCount} icon={<FaMoneyBillWave />} isLoading={isLoading} />

                <HeadingCard title='Semi-Monthly Salary' count={formatter.format(basicSalary || 0)} icon={<FcMoneyTransfer />} isLoading={bsLoad} />

            </div>
        </>
    )
}

export default PayslipCards