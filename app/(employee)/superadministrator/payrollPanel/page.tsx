import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import GeneratePayroll from '../_components/generate-payroll'

const page = () => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Payroll Management'>
                <div>
                    <GeneratePayroll />
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page