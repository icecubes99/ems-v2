"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import { CreateHolidayCard } from '../_components/create-holidays'
import WorkingDaysManager from '../_components/create-workingdays-months'
import { PasswordsTable } from '@/components/passwords-table'
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
import { useHolidays } from '@/hooks/use-holidays'
import { columnsHolidays } from '../_components/columns-holidays'
import TableWrapper from '@/components/table-wrapper'
import { MdBeachAccess, MdEventAvailable, MdHolidayVillage, MdLock, MdWork } from 'react-icons/md'
import { useRemainingWorkingDaysCount, useTotalHolidaysCount, useTotalWorkingDaysCount } from '@/hooks/use-ModelCounts'
import HeadingCard from '@/components/heading-card'
import QuickActions from '@/components/quick-actions'

const page = () => {
    const { holidays, } = useHolidays()
    const { workingDays, isLoading: twLoading } = useTotalWorkingDaysCount();
    const { remainingDays, isLoading: rwLoading } = useRemainingWorkingDaysCount();
    const { holidaysCount, isLoading: hLoading } = useTotalHolidaysCount()
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead classname=' '>
                <div className='mt-5'>
                    <p className='font-bold text-4xl'>TIMESHEET CONTROLS</p>
                </div>

                <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5   ">
                    <HeadingCard title='Total Working Days' count={workingDays} icon={<MdWork />} isLoading={twLoading} />
                    <HeadingCard title='Remaining Working Days' count={remainingDays} icon={<MdEventAvailable />} isLoading={rwLoading} />
                    <HeadingCard title='Total Holidays' count={holidaysCount} icon={<MdBeachAccess />} isLoading={hLoading} />
                </div>

                <QuickActions className='lg:grid-cols-3'>
                    <WorkingDaysManager classname='col-span-1' />
                    <CreateHolidayCard />
                </QuickActions>

                <div className='grid grid-cols-2 gap-8'>
                    <TableWrapper description='List of Passwords for the Working Day' title='Passwords' icon={<MdLock />}>
                        <PasswordsTable />
                    </TableWrapper>
                    <TableWrapper description='Days without any work' title='Holidays' icon={<MdBeachAccess />}>
                        <DataTableTemplate columns={columnsHolidays} data={holidays || []} />
                    </TableWrapper>
                </div>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page
