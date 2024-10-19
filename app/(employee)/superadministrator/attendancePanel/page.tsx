"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import { CreateHolidayCard } from '../_components/create-holidays'
import WorkingDaysManager from '../_components/create-workingdays-months'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { HolidayTable } from '@/components/holidays-table'
import { PasswordsTable } from '@/components/passwords-table'
import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import { useHolidays } from '@/hooks/use-holidays'
import { columnsHolidays } from '../_components/columns-holidays'
import TableWrapper from '@/components/table-wrapper'
import { MdHolidayVillage } from 'react-icons/md'

const page = () => {
    const { holidays, isLoading, error } = useHolidays()
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead classname='mr-6'>
                <div className='flex flex-col gap-6'>
                    <div className='mt-5'>
                        <p className='font-bold text-4xl'>TIMESHEET CONTROLS</p>
                    </div>
                    <div className='grid grid-cols-4 gap-8'>

                        <WorkingDaysManager classname='col-span-2' />
                        <HolidayCard classname='col-span-2' />
                    </div>
                    <div className='grid grid-cols-2 gap-8'>
                        <PasswordsTable />
                        <TableWrapper description='Holidays' title='Holidays' icon={<MdHolidayVillage />}>
                            <DataTableRemainingLeaves columns={columnsHolidays} data={holidays || []} />
                        </TableWrapper>
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