"use client"

import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import { useApprovedDeniedOvertimes, usePendingOvertimes } from '@/hooks/use-pending-overtimes'
import React from 'react'
import { columnsPendingOvertimes } from '../manageLeaves/columns-pending-overtimes'
import TableWrapper from '@/components/table-wrapper'
import { columnsApprovedOvertimes } from '../_components/columns-approved-overtimes'
import { StopwatchIcon } from '@radix-ui/react-icons'
import { CheckSquare } from 'lucide-react'

const Page = () => {
    const { overtimes, isLoading, error } = usePendingOvertimes()
    const { overtimes: adOvertime, isLoading: adIsLoading, error: adIsError } = useApprovedDeniedOvertimes()

    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead>
                <div className='mt-5 mb-5'>
                    <p className='font-bold text-4xl'>MANAGE OVERTIMES</p>
                </div>
                <div className=''>
                    {
                        isLoading ? (

                            <div></div>
                        ) : error ? (
                            <div></div>
                        ) : (
                            <>
                                <TableWrapper title='Pending Overtime Requests' description='View Pending Overtime Requests' icon={<StopwatchIcon />}>
                                    <DataTableTemplate searchValue='userId' searchName='User' columns={columnsPendingOvertimes} data={overtimes || []} />
                                </TableWrapper>


                            </>
                        )
                    }
                </div>
                <div className=''>
                    {
                        adIsLoading ? (

                            <div></div>
                        ) : adIsError ? (
                            <div></div>
                        ) : (
                            <>
                                <TableWrapper title='Approved or Rejected ORs' description='View Overtime Requests' icon={<CheckSquare />}>
                                    <DataTableTemplate searchValue='userId' searchName='User' columns={columnsApprovedOvertimes} data={adOvertime || []} />
                                </TableWrapper>


                            </>
                        )
                    }
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default Page