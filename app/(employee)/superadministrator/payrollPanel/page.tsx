import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import GeneratePayroll from '../_components/generate-payroll'
import PayrollPanelCards from './_components/payroll-panel-cards'
import HeadingTitle from '@/components/heading-title'

const page = () => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Payroll Panel'>

                <HeadingTitle title='PAYROLL MANAGEMENT' />

                <PayrollPanelCards />
                <div>
                    <GeneratePayroll />
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page