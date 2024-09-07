"use client"
import { useCurrentUser } from '@/hooks/use-current-user';
import React, { use } from 'react'
import HomepageCards from '../_components/HomepageCards';
import { RoleGate } from '@/components/auth/role-gate';
import LayoutSideHead from '@/components/LayoutSideHead';


const HomePage = () => {
    const user = useCurrentUser();

    return (
        <RoleGate allowedRoles={["USER", "ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead label='HOME PAGE' classname=''>
                <HomepageCards />

            </LayoutSideHead>
        </RoleGate>
    )
}

export default HomePage