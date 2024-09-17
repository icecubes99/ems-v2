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
            <LayoutSideHead label='Attendance Control' classname='mr-6'>
                <div className='flex flex-col gap-6'>
                    <div className='mt-5'>
                        <p className='font-bold text-4xl'>TIMESHEET CONTROLS</p>
                    </div>
                    <div className='grid grid-cols-4 gap-8'>

                        <WorkingDaysManager classname='col-span-2' />
                        <HolidayCard classname='col-span-2' />
                    </div>
                    <div className='grid grid-cols-2 gap-8'>
                        <HolidayTable />
                        <PasswordsTable />
                    </div>
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page

function HolidayCard({ classname }: { classname?: string }) {
    return (
        <Card className={classname}>
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