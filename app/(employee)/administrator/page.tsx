"use client"
import { RoleGate } from '@/components/auth/role-gate'
import React from 'react'
import { useCurrentUser } from '@/hooks/use-current-user';
import LayoutSideHead from '@/components/LayoutSideHead';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import CreateDepartmentButton from '../superadministrator/_components/CreateDepartmentButton';
import AdminCards from './_components/AdminCards';

const AdminPage = () => {
    const user = useCurrentUser();

    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead label='ADMIN PAGE'>
                <AdminCards />
                {/* <CreateDepartmentButton /> */}
            </LayoutSideHead>
        </RoleGate>
    )
}

export default AdminPage