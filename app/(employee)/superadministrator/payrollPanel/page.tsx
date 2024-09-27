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
import { DollarSign } from 'lucide-react'
import { useDeductions } from '@/hooks/use-deductions'
import { columnsDeduction } from './_components/columns-deductions'
import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import { usePendingLeaves } from '@/hooks/use-pending-leaves'

const page = () => {
    const { deductions } = useDeductions()
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Payroll Panel'>

                <HeadingTitle title='PAYROLL MANAGEMENT' />

                <PayrollPanelCards />
                <QuickActions>
                    <AddDeductionsForm variant={"superadmin"} />
                </QuickActions>
                <div>
                    <GeneratePayroll />
                </div>

                <div className='grid grid-cols-2'>
                    <TableWrapper title='Deductions' description='Deductions for the Upcoming Payroll Period' icon={<DollarSign />}>
                        <DataTableRemainingLeaves columns={columnsDeduction} data={deductions || []} />
                    </TableWrapper>
                </div>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page