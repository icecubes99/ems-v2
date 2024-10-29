import HeadingTitle from '@/components/heading-title'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import { PayrollDashboard, YearlyPayrollDashboard } from '../_components/payroll-dashboard'

const page = () => {
    return (
        <LayoutSideHead>
            <HeadingTitle title='PAYROLL DASHBOARD' />
            <PayrollDashboard />
            <YearlyPayrollDashboard />
        </LayoutSideHead>
    )
}

export default page