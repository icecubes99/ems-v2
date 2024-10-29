"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import GeneratePayroll from '../_components/generate-payroll'
import PayrollPanelCards from './_components/payroll-panel-cards'
import HeadingTitle from '@/components/heading-title'
import AddDeductionsForm from '../../administrator/_components/deductions-form'
import TableWrapper from '@/components/table-wrapper'
import { BadgeDollarSign, DollarSign } from 'lucide-react'
import { useDeductions } from '@/hooks/use-deductions'
import { columnsDeduction } from './_components/columns-deductions'
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import AddAdditionalEarningsForm from '../../administrator/_components/additional-earnings-form'
import { useAdditionalEarnings } from '@/hooks/use-additional-earnings'
import { columnsAdditionalEarnings } from './_components/columns-additional-earnings'
import { usePendingPayroll } from '@/hooks/use-payroll-data'
import { columnsPendingPayroll } from './_components/columns-pending-payroll'
import IncreaseDepartmentalSalaryForm from './_components/increase-departmental-salary-form'
import IncreaseDesignationalSalaryForm from './_components/increase-designational-salary-form'
import { columnsSalaryIncreaseEvent } from './_components/columns-salary-increase-event'
import { useSalaryIncreaseEvents } from '@/hooks/use-salary-increase-events'
import { DataTableDeductions } from './_components/data-table-deductions'
import { DataTableAdditionalEarnings } from './_components/data-table-additional-earnings'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { cn } from '@/lib/utils'
import { GeneratePayrollManualDialog } from './_components/generate-payroll-manual-dialog'
import DecreaseDepartmentalSalaryForm from './_components/decrease-departmental-salary-form'
import DecreaseDesignationalSalaryForm from './_components/decrease-designational-salary-form'

const page = () => {
    const { deductions } = useDeductions()
    const { additionalEarnings } = useAdditionalEarnings()
    const { payroll } = usePendingPayroll()
    const { salaryIncreaseEvents } = useSalaryIncreaseEvents()
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead>

                <HeadingTitle title='PAYROLL MANAGEMENT' />

                <PayrollPanelCards />
                <QuickActions>
                    <GeneratePayroll className='col-span-1 mt-0' />

                    <AddDeductionsForm variant={"superadmin"} />
                    <AddAdditionalEarningsForm variant={"superadmin"} />

                    <IncreaseDepartmentalSalaryForm />
                    <IncreaseDesignationalSalaryForm />

                    <DecreaseDepartmentalSalaryForm />
                    <DecreaseDesignationalSalaryForm />
                </QuickActions>
                <QuickActions title='ADVANCED' className='lg:grid-cols-4'>
                    <GeneratePayrollManualDialog />
                    <Link href={"/superadministrator/payrollPanel/editGovernmentContributions"}>
                        <Button className='w-full' size={"lg"} variant={"outline"}>
                            Edit Government Contributions
                        </Button>
                    </Link>
                    <Link href={"/superadministrator/payrollPanel/payroll"}>
                        <Button className='w-full' size={"lg"} variant={"outline"}>
                            View Dashboard
                        </Button>
                    </Link>
                </QuickActions>
                <div>
                </div>

                <TableWrapper title='Pending Payroll' description='Payroll That Needs Approval' icon={<BadgeDollarSign />}>
                    <DataTableTemplate columns={columnsPendingPayroll} data={payroll || []} />
                </TableWrapper>

                <div className='grid grid-cols-2 gap-2'>
                    <TableWrapper title='Deductions' description='Deductions for the Upcoming Payroll Period' icon={<DollarSign />}>
                        <DataTableDeductions columns={columnsDeduction} data={deductions || []} />
                    </TableWrapper>

                    <TableWrapper title='Additional Earnings' description='Additional Earnings for the Upcoming Payroll Period' icon={<DollarSign />}>
                        <DataTableAdditionalEarnings columns={columnsAdditionalEarnings} data={additionalEarnings || []} />
                    </TableWrapper>
                </div>

                <TableWrapper title='Salary Changes Events' description='Salary Increase or Decrease Events' icon={<DollarSign />}>
                    <DataTableTemplate columns={columnsSalaryIncreaseEvent} data={salaryIncreaseEvents || []} />
                </TableWrapper>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page

interface QuickActionsProps {
    children: React.ReactNode
    title?: string
    className?: string
}

const QuickActions = ({ children, title, className }: QuickActionsProps) => {
    return (
        <>
            <p className="col-span-4 font-bold text-lg mt-6">{title || "QUICK ACTIONS"}</p>
            <div className={cn("grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3 mb-8 mt-5   items-center justify-center", className)}>
                {children}
            </div>
        </>
    )
}
