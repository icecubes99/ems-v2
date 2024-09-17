"use client"

import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import { usePendingOvertimes } from '@/hooks/use-pending-overtimes'
import React from 'react'
import { columnsPendingOvertimes } from '../manageLeaves/columns-pending-overtimes'

const Page = () => {
    const { overtimes, isLoading, error } = usePendingOvertimes()

    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead label='Overtime Requests Management'>
                <div className='mt-5 mb-5'>
                    <p className='font-bold text-4xl'>MANAGE OVERTIMES</p>
                </div>
                <div className='mr-6'>
                    {
                        isLoading ? (

                            <div></div>
                        ) : error ? (
                            <div></div>
                        ) : (
                            <>
                                <DataTableRemainingLeaves label='PENDING OVERTIMES NEED FOR APPROVAL' columns={columnsPendingOvertimes} data={overtimes || []} />
                            </>
                        )
                    }
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default Page