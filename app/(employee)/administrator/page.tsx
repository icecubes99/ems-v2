"use client"
import { RoleGate } from '@/components/auth/role-gate'
import React from 'react'
import { useCurrentUser } from '@/hooks/use-current-user';
import LayoutSideHead from '@/components/LayoutSideHead';
import { Button } from '@/components/ui/button';
import Link from 'next/link';

const AdminPage = () => {
    const user = useCurrentUser();

    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead label='ADMIN PAGE'>
                <Button asChild>
                    <Link href={"/administrator/userList"}>
                        User List
                    </Link>
                </Button>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default AdminPage