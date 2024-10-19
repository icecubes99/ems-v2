"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import GeneratePayroll from '../_components/generate-payroll'
import PayrollPanelCards from './_components/payroll-panel-cards'
import HeadingTitle from '@/components/heading-title'
import QuickActions from '@/components/quick-actions'
import AddDeductionsForm from '../../administrator/_components/deductions-form'
import TableWrapper from '@/components/table-wrapper'
import { BadgeDollarSign, DollarSign } from 'lucide-react'
import { useDeductions } from '@/hooks/use-deductions'
import { columnsDeduction } from './_components/columns-deductions'
import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import AddAdditionalEarningsForm from '../../administrator/_components/additional-earnings-form'
import { useAdditionalEarnings } from '@/hooks/use-additional-earnings'
import { columnsAdditionalEarnings } from './_components/columns-additional-earnings'
import { usePendingPayroll } from '@/hooks/use-payroll-data'
import { columnsPendingPayroll } from './_components/columns-pending-payroll'
import IncreaseDepartmentalSalaryForm from './_components/increase-departmental-salary-form'
import IncreaseDesignationalSalaryForm from './_components/increase-designational-salary-form'
import { columnsSalaryIncreaseEvent } from './_components/columns-salary-increase-event'
import { useSalaryIncreaseEvents } from '@/hooks/use-salary-increase-events'

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

                    <GeneratePayroll className='col-span-2 mt-0' />

                    <div className='flex flex-col justify-around'>
                        <AddDeductionsForm variant={"superadmin"} />
                        <AddAdditionalEarningsForm variant={"superadmin"} />

                    </div>
                    <div className='flex flex-col justify-around'>
                        <IncreaseDepartmentalSalaryForm />
                        <IncreaseDesignationalSalaryForm />
                    </div>

                </QuickActions>
                <div>
                </div>

                <TableWrapper title='Pending Payroll' description='Payroll That Needs Approval' icon={<BadgeDollarSign />}>
                    <DataTableRemainingLeaves columns={columnsPendingPayroll} data={payroll || []} />
                </TableWrapper>

                <div className='grid grid-cols-2'>
                    <TableWrapper title='Deductions' description='Deductions for the Upcoming Payroll Period' icon={<DollarSign />}>
                        <DataTableRemainingLeaves columns={columnsDeduction} data={deductions || []} />
                    </TableWrapper>

                    <TableWrapper title='Additional Earnings' description='Additional Earnings for the Upcoming Payroll Period' icon={<DollarSign />}>
                        <DataTableRemainingLeaves columns={columnsAdditionalEarnings} data={additionalEarnings || []} />
                    </TableWrapper>
                </div>

                <TableWrapper title='Salary Increase Events' description='Salary Increase Events' icon={<DollarSign />}>
                    <DataTableRemainingLeaves columns={columnsSalaryIncreaseEvent} data={salaryIncreaseEvents || []} />
                </TableWrapper>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page