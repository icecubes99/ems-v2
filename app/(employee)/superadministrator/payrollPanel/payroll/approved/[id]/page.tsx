"use client"
import { RoleGate } from '@/components/auth/role-gate'
import HeadingTitle from '@/components/heading-title'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'

const page = ({ params }: { params: { id: string } }) => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead>
                <HeadingTitle title={`Payroll #${params.id}`} />

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page