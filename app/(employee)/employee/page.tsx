"use client"
import React from 'react'
import EmployeeDetails from '../_components/EmployeeDetails'
import LayoutSideHead from '@/components/LayoutSideHead'
import { useCurrentUser, useCurrentUserId } from '@/hooks/use-current-user'
import AddressCard from '../_components/_AddressComponents/AddressCard'
import EmergencyContactCard from '../_components/_EmergencyContactComponents/EmergencyContactCard'
import QuickActions from '@/components/quick-actions'
import { UploadProfilePictureForm } from '../_components/upload-profile-picture'
import { useUserImage } from '@/hooks/use-user-image'
import TableWrapper from '@/components/table-wrapper'
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import { useAuditLogs, useUserAuditLog } from '@/hooks/use-audit-logs'
import { SearchCodeIcon } from 'lucide-react'
import { columnsUserAuditLogs } from '../administrator/_components/columns-user-audit-logs'
import ChangePasswordForm from '../_components/change-password'

const Page = () => {
    const user = useCurrentUser();
    const userId = useCurrentUserId() as string;
    const { userImage } = useUserImage();
    const { auditLogs } = useUserAuditLog(userId);


    return (
        <LayoutSideHead>

            <EmployeeDetails>
                <AddressCard userId={userId} />
                <EmergencyContactCard userId={userId} />
            </EmployeeDetails>

            <QuickActions>
                <UploadProfilePictureForm userId={userId} initialProfilePicture={userImage || undefined} />
                <ChangePasswordForm />
            </QuickActions>

            <TableWrapper description='All Your Recent Actions' title='Audit Log' icon={<SearchCodeIcon />}>
                <DataTableTemplate columns={columnsUserAuditLogs} data={auditLogs || []} />
            </TableWrapper>
        </LayoutSideHead>
    )
}

export default Page