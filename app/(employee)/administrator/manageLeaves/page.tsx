"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'

import { columnsRemainingLeaves } from '@/app/(leaves)/_components/columns-remaining-leaves'
import { useRemainingLeaves } from '@/hooks/use-remaining-leaves'
import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import { usePendingLeaves } from '@/hooks/use-pending-leaves'
import { columnsPendingLeaves } from '@/app/(leaves)/_components/columns-pending-leaves'

const Page = () => {
    const { leaves, isLoading, error } = useRemainingLeaves()
    const { leaves: pendingLeaves, isLoading: pendingLoading, error: pendingError } = usePendingLeaves()


    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead label='Leave Requests Management'>
                <div className='mt-5 mb-5'>
                    <p className='font-bold text-4xl'>MANAGE LEAVES</p>
                </div>
                <div className='mr-6'>
                    {pendingLoading ? (
                        <div></div>
                    ) : pendingError ? (
                        <div></div>
                    ) : (
                        <>
                            <DataTableRemainingLeaves label='PENDING LEAVES NEED FOR APPROVAL' columns={columnsPendingLeaves} data={pendingLeaves || []} />
                        </>
                    )}

                    <hr className="my-8 border-t-2 border-gray-300/60" />

                    {isLoading ? (
                        <div></div>
                    ) : error ? (
                        <div></div>
                    ) : (

                        <DataTableRemainingLeaves label='REQUEST HISTORY' columns={columnsRemainingLeaves} data={leaves || []} />
                    )}
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default Page