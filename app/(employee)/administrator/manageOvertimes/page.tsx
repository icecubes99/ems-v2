"use client"

import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import { usePendingOvertimes } from '@/hooks/use-pending-overtimes'
import React from 'react'
import { columnsPendingOvertimes } from '../manageLeaves/columns-pending-overtimes'
import { History } from 'lucide-react'

const Page = () => {
    const { overtimes, isLoading, error } = usePendingOvertimes()

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
                                <div className='bg-card  rounded-xl shadow'>
                                    <div className='p-6 border-b border-border'>
                                        <h2 className='text-2xl font-semibold flex items-center gap-2'>
                                            <History className='h-6 w-6 text-primary' />
                                            Pending Overtime Requests
                                        </h2>
                                        <p className='text-muted-foreground mt-1'>View Pending Overtime Requests</p>
                                    </div>
                                    <div className='p-6'>
                                        <DataTableTemplate columns={columnsPendingOvertimes} data={overtimes || []} />
                                    </div>
                                </div>
                            </>
                        )
                    }
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default Page