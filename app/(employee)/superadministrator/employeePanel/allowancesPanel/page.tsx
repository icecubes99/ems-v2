'use client'
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import HeadingTitle from '@/components/heading-title'
import LayoutSideHead from '@/components/LayoutSideHead'
import TableWrapper from '@/components/table-wrapper'
import { DollarSign, X } from 'lucide-react'
import React from 'react'
import { columnsActiveAllowances } from '../_components/columns-active-allowances'
import { useActiveAllowances, useInactiveAllowances } from '@/hooks/use-allowances'
import CreateAllowances from '../../payrollPanel/_components/create-allowances-form'
import { columnsInactiveAllowances } from '../_components/columns-inactive-allowances'

const page = () => {
    const { allowances } = useActiveAllowances()
    const { allowances: inactiveAllowances } = useInactiveAllowances()
    return (
        <LayoutSideHead>
            <HeadingTitle title="ALLOWANCES PANEL">
                <CreateAllowances smallButton />
            </HeadingTitle>
            <TableWrapper title='Active Allowances' description='All the Active Allowances' icon={<DollarSign />}>
                <DataTableTemplate columns={columnsActiveAllowances} data={allowances || []} />
            </TableWrapper>
            <TableWrapper title='Inactive Allowances' description='All the Not Active Allowances' icon={<X />}>
                <DataTableTemplate columns={columnsInactiveAllowances} data={inactiveAllowances || []} />
            </TableWrapper>

        </LayoutSideHead>
    )
}

export default page