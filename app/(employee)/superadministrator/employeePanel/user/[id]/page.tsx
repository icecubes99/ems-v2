"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import EmployeeDetailsV2 from '../../_components/employee-details-v2'
import AddressCard from '@/app/(employee)/_components/_AddressComponents/AddressCard'
import EmergencyContactCard from '@/app/(employee)/_components/_EmergencyContactComponents/EmergencyContactCard'
import OtherLeavesTable from '../../_components/other-leaves-table'
import { History } from 'lucide-react'

const page = ({ params }: { params: { id: string } }) => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='EMPLOYEE PROFILE'>
                <EmployeeDetailsV2 userId={params.id}>
                    <AddressCard userId={params.id} />
                    <EmergencyContactCard userId={params.id} />
                </EmployeeDetailsV2>


                <div className='bg-card mt-5 rounded-xl shadow mr-6 mb-6 hover:shadow-md'>
                    <div className='p-6 border-b border-border'>
                        <h2 className='text-2xl font-semibold flex items-center gap-2'>
                            <History className='h-6 w-6 text-primary' />
                            Leave Requests History
                        </h2>
                        <p className='text-muted-foreground mt-1'>View past and current leave requests</p>
                    </div>
                    <div className='p-6'>
                        <OtherLeavesTable userId={params.id} />
                    </div>
                </div>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page