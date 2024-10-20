"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'

import { columnsRemainingLeaves } from '@/app/(leaves)/_components/columns-remaining-leaves'
import { useRemainingLeaves } from '@/hooks/use-remaining-leaves'
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import { usePendingLeaves } from '@/hooks/use-pending-leaves'
import { columnsPendingLeaves } from '@/app/(leaves)/_components/columns-pending-leaves'
import { History } from 'lucide-react'

const Page = () => {
    const { leaves, isLoading, error } = useRemainingLeaves()
    const { leaves: pendingLeaves, isLoading: pendingLoading, error: pendingError } = usePendingLeaves()


    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead>
                <div className='mt-5 mb-5'>
                    <p className='font-bold text-4xl'>MANAGE LEAVES</p>
                </div>
                <div className=''>
                    {pendingLoading ? (
                        <div></div>
                    ) : pendingError ? (
                        <div></div>
                    ) : (
                        <>
                            <div className='bg-card  rounded-xl shadow '>
                                <div className='p-6 border-b border-border'>
                                    <h2 className='text-2xl font-semibold flex items-center gap-2'>
                                        <History className='h-6 w-6 text-primary' />
                                        Pending Leaves History
                                    </h2>
                                    <p className='text-muted-foreground mt-1'>View pending leave requests</p>
                                </div>
                                <div className='p-6'>
                                    <DataTableTemplate columns={columnsPendingLeaves} data={pendingLeaves || []} />
                                </div>
                            </div>
                        </>
                    )}

                    <hr className="my-8 border-t-2 border-gray-300/60" />

                    {isLoading ? (
                        <div></div>
                    ) : error ? (
                        <div></div>
                    ) : (
                        <>
                            <div className='bg-card  rounded-xl shadow'>
                                <div className='p-6 border-b border-border'>
                                    <h2 className='text-2xl font-semibold flex items-center gap-2'>
                                        <History className='h-6 w-6 text-primary' />
                                        Leaves History
                                    </h2>
                                    <p className='text-muted-foreground mt-1'>View previous leave requests</p>
                                </div>
                                <div className='p-6'>
                                    <DataTableTemplate columns={columnsRemainingLeaves} data={leaves || []} />
                                </div>
                            </div>
                        </>
                    )}
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default Page