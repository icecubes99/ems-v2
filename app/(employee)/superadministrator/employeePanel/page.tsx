import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import EmployeePageContent from './_components/employee-page-content'

const page = () => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Employee Panel'>
                <EmployeePageContent />
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page
