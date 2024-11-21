"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import EmployeeDetailsV2 from '../../_components/employee-details-v2'
import AddressCard from '@/app/(employee)/_components/_AddressComponents/AddressCard'
import EmergencyContactCard from '@/app/(employee)/_components/_EmergencyContactComponents/EmergencyContactCard'
import OtherLeavesTable from '../../_components/other-leaves-table'
import { ArchiveIcon, SearchCodeIcon } from 'lucide-react'
import TableWrapper from '@/components/table-wrapper'
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import { columnsUserAuditLogs } from '@/app/(employee)/administrator/_components/columns-user-audit-logs'
import { useUserAuditLog } from '@/hooks/use-audit-logs'
import { useUserDocuments } from '@/hooks/use-documents'
import { IoDocument } from 'react-icons/io5'
import { columnsUserDocuments } from '@/app/(employee)/_components/columns-user-documents'
import QuickActions from '@/components/quick-actions'
import { Button } from '@/components/ui/button'
import { ChangeUserRoleDialog } from '../../_components/change-user-role-dialog'
import { ChangeOtherPasswordForm } from '@/app/(employee)/_components/change-password'
import { EditUserDetailsDialog } from '../../_components/edit-user-details-dialog'
import { StopwatchIcon } from '@radix-ui/react-icons'
import HeadingTitle from '@/components/heading-title'
import { ArchiveUserDialog } from '../../_components/archive-user-dialog'

const page = ({ params }: { params: { id: string } }) => {
    const { auditLogs } = useUserAuditLog(params.id);
    const { documents } = useUserDocuments(params.id);
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead>
                <QuickActions className='flex justify-between'>
                    <div className='flex flex-row gap-2'>
                        <EditUserDetailsDialog userId={params.id} />
                        <ChangeUserRoleDialog userId={params.id} />
                        <ChangeOtherPasswordForm userId={params.id} />
                    </div>
                    <div>
                        <ArchiveUserDialog userId={params.id} />
                    </div>
                </QuickActions>
                <div className='px-5 py-2 pb-4 rounded-md border '>
                    <EmployeeDetailsV2 userId={params.id}>
                        <AddressCard userId={params.id} />
                        <EmergencyContactCard userId={params.id} />
                    </EmployeeDetailsV2>

                    <TableWrapper title='Leave Requests History' description='View past and current leave requests' icon={<StopwatchIcon />}>
                        <OtherLeavesTable userId={params.id} />
                    </TableWrapper>

                    <div className='grid grid-cols-2 gap-2'>

                        <TableWrapper description='All Recent Actions' title='Audit Log' icon={<SearchCodeIcon />}>
                            <DataTableTemplate columns={columnsUserAuditLogs} data={auditLogs || []} />
                        </TableWrapper>

                        <TableWrapper title='User Documents' description="This User's Documents" icon={<IoDocument />}>
                            <DataTableTemplate columns={columnsUserDocuments} data={documents || []} />
                        </TableWrapper>
                    </div>


                </div>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page