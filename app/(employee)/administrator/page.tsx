"use client"
import { RoleGate } from '@/components/auth/role-gate'
import React from 'react'
import { useCurrentUser } from '@/hooks/use-current-user';
import LayoutSideHead from '@/components/LayoutSideHead';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import AdminCards from './_components/AdminCards';
import DesignationHeadCard from './_components/designation-head-control-card';

const AdminPage = () => {
    const user = useCurrentUser();

    if (!user) {
        return <div>Loading...</div>; // or handle the undefined case appropriately
    }

    const userId = user.id as string;

    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead label='Administrator Panel'>
                <AdminCards userId={userId} />
            </LayoutSideHead>
        </RoleGate>
    )
}

export default AdminPage