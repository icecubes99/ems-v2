"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import EmployeeDetailsV2 from '../../_components/employee-details-v2'
import AddressCard from '@/app/(employee)/_components/_AddressComponents/AddressCard'
import EmergencyContactCard from '@/app/(employee)/_components/_EmergencyContactComponents/EmergencyContactCard'
import OtherLeavesTable from '../../_components/other-leaves-table'
import { History, SearchCodeIcon } from 'lucide-react'
import TableWrapper from '@/components/table-wrapper'
import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import { columnsUserAuditLogs } from '@/app/(employee)/administrator/_components/columns-user-audit-logs'
import { useUserAuditLog } from '@/hooks/use-audit-logs'

const page = ({ params }: { params: { id: string } }) => {
    const { auditLogs } = useUserAuditLog(params.id);
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='EMPLOYEE PROFILE'>
                <EmployeeDetailsV2 userId={params.id}>
                    <AddressCard userId={params.id} />
                    <EmergencyContactCard userId={params.id} />
                </EmployeeDetailsV2>

                <TableWrapper title='Leave Requests History' description='View past and current leave requests' icon={<History />}>
                    <OtherLeavesTable userId={params.id} />
                </TableWrapper>

                <TableWrapper description='All Recent Actions' title='Audit Log' icon={<SearchCodeIcon />}>
                    <DataTableRemainingLeaves columns={columnsUserAuditLogs} data={auditLogs || []} />
                </TableWrapper>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page