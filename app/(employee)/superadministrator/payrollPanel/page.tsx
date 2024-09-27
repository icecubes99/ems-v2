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
import AddAdditionalEarningsForm from '../../administrator/_components/additional-earnings-form'
import { useAdditionalEarnings } from '@/hooks/use-additional-earnings'
import { columnsAdditionalEarnings } from './_components/columns-additional-earnings'
import { Button } from '@/components/ui/button'

const page = () => {
    const { deductions } = useDeductions()
    const { additionalEarnings } = useAdditionalEarnings()
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Payroll Panel'>

                <HeadingTitle title='PAYROLL MANAGEMENT' />

                <PayrollPanelCards />
                <QuickActions>

                    <GeneratePayroll className='col-span-2 mt-0' />

                    <div className='flex flex-col justify-around'>
                        <AddDeductionsForm variant={"superadmin"} />
                        <AddAdditionalEarningsForm variant={"superadmin"} />
                        <Button variant={"auth"} size={"lg"}>
                            Test
                        </Button>
                    </div>

                </QuickActions>
                <div>
                </div>

                <div className='grid grid-cols-2'>
                    <TableWrapper title='Deductions' description='Deductions for the Upcoming Payroll Period' icon={<DollarSign />}>
                        <DataTableRemainingLeaves columns={columnsDeduction} data={deductions || []} />
                    </TableWrapper>

                    <TableWrapper title='Additional Earnings' description='Additional Earnings for the Upcoming Payroll Period' icon={<DollarSign />}>
                        <DataTableRemainingLeaves columns={columnsAdditionalEarnings} data={additionalEarnings || []} />
                    </TableWrapper>
                </div>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page