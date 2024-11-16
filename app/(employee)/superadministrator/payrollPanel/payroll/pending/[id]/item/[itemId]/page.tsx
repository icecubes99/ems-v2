"use client"

import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import HeadingTitle from '@/components/heading-title'
import LayoutSideHead from '@/components/LayoutSideHead'
import TableWrapper from '@/components/table-wrapper'
import React from 'react'
import { columnsPayslipItemTimesheets } from '@/app/(employee)/superadministrator/payrollPanel/_components/columns-payslip-item-timesheets'
import { usePayrollItemTimesheets } from '@/hooks/use-payroll-item-timesheets'

const page = ({ params }: { params: { itemId: string } }) => {
    const { timesheets } = usePayrollItemTimesheets(params.itemId);

    return (
        <LayoutSideHead>
            <HeadingTitle title='Payroll Item' />
            <TableWrapper title='Payroll Item Attendances' description=''>
                <DataTableTemplate columns={columnsPayslipItemTimesheets} data={timesheets || []} />
            </TableWrapper>
        </LayoutSideHead>
    )
}

export default page