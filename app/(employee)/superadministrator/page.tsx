"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React, { useState } from 'react'
import SuperAdminCards from './_components/SuperAdminCards'
import SelectUser from '../_components/SelectUser'

const page = () => {
    const [selectedUserId, setSelectedUserId] = useState<string | null>(null);

    const handleUserSelect = (id: string) => {
        setSelectedUserId(id);
        console.log('Selected User ID:', id);
    };

    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Super Administrator Panel'>
                <SuperAdminCards />
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page