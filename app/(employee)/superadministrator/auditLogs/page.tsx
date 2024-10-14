"use client"
import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import HeadingCard from '@/components/heading-card'
import HeadingTitle from '@/components/heading-title'
import LayoutSideHead from '@/components/LayoutSideHead'
import QuickActions from '@/components/quick-actions'
import TableWrapper from '@/components/table-wrapper'
import React from 'react'
import { columnsAuditLogs } from './_components/columns-audit-logs'
import { useAuditLogs } from '@/hooks/use-audit-logs'

const page = () => {
    const { auditLogs } = useAuditLogs()
    return (
        <LayoutSideHead label='Audit Logs'>
            <HeadingTitle title='AUDITS TABLE' />

            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-3 mt-5 mr-6 ">
                <HeadingCard title='Total Audited Action' count={10} />
            </div>

            <TableWrapper title='System Audit Logs' description=''>
                <DataTableRemainingLeaves data={auditLogs || []} columns={columnsAuditLogs} />
            </TableWrapper>

        </LayoutSideHead>
    )
}

export default page