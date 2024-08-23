
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import UserList from '../../_components/UserList'

const page = () => {
    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead label='UserList'>
                <div className='mx-5'>
                    <UserList />
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page