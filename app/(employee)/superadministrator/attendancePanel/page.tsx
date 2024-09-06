import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import CreateHolidayCard from '../_components/create-holidays'
import WorkingDaysManager from '../_components/create-workingdays-months'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { HolidayTable } from '@/components/holidays-table'
import { PasswordsTable } from '@/components/passwords-table'

const page = () => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Attendance Control'>
                <div className='grid grid-cols-2 gap-8'>

                    <WorkingDaysManager />
                    <HolidayCard />
                    <HolidayTable />
                    <PasswordsTable />
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page

function HolidayCard() {
    return (
        <Card>
            <CardHeader>
                <CardTitle>
                    Add Holidays
                </CardTitle>
                <CardDescription>
                    This would not be included in the Working Days
                </CardDescription>
            </CardHeader>
            <CardContent>
                <div className='w-full'>
                    <CreateHolidayCard />
                </div>
            </CardContent>
        </Card>
    )
}