import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import React from 'react'
import Link from 'next/link'
import DesignationHeadCard from './designation-head-control-card'
import DepartmentHeadCard from './department-head-control-card'
import { PasswordsTable } from '@/components/passwords-table'
import { Users, FileText, Clock, Building, UserCircle } from 'lucide-react'
import { useLeavesPendingCount, useOvertimesPendingCount } from '@/hooks/use-ModelCounts'
import HeadingTitle from '@/components/heading-title'

interface AdminCardsProps {
    userId: string
}

const AdminCards = ({ userId }: AdminCardsProps) => {
    const { pendingLeavesCount } = useLeavesPendingCount()
    const { pendingOvertimesCount } = useOvertimesPendingCount()
    return (
        <div className='flex flex-col gap-6 mb-2'>

            <HeadingTitle title='ACTIONS' />

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 pr-6">
                <div className='row-span-3'>
                    <PasswordsTable classname='w-full' />
                </div>

                <Card className="flex flex-col">
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <UserCircle className="h-6 w-6" />
                            User Actions
                        </CardTitle>
                        <CardDescription>
                            User management and actions
                        </CardDescription>
                    </CardHeader>
                    <CardContent className='flex-grow'>
                        <div className='flex items-center justify-between'>
                            <p className='text-sm font-medium'>Employees List</p>
                        </div>
                    </CardContent>
                    <CardFooter className="mt-auto">
                        <Link href="/administrator/dataTable" passHref legacyBehavior className="w-full">
                            <Button variant="admin" className="w-full">
                                View Employees
                            </Button>
                        </Link>
                    </CardFooter>
                </Card>

                <DesignationHeadCard userId={userId} />
                <DepartmentHeadCard userId={userId} />

                <Card className="flex flex-col">
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <FileText className="h-6 w-6" />
                            Leave Requests Panel
                        </CardTitle>
                        <CardDescription>Manage, Approve and Deny Requests</CardDescription>
                    </CardHeader>
                    <CardContent className='flex-grow'>
                        {(pendingLeavesCount ?? 0) > 0 ? (
                            <p className='text-sm text-gray-600'>You have <span className='text-red-500 font-bold'>{pendingLeavesCount}</span> leave requests to approve or deny!</p>
                        ) : (
                            <p className='text-sm text-gray-600'>No pending leave requests.</p>
                        )}
                    </CardContent>
                    <CardFooter className="mt-auto">
                        <Link href="/administrator/manageLeaves" passHref legacyBehavior className="w-full">
                            <Button className="w-full" variant="admin">
                                Manage Leave Requests
                            </Button>
                        </Link>
                    </CardFooter>
                </Card>

                <Card className="flex flex-col">
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <Clock className="h-6 w-6" />
                            Overtime Requests Panel
                        </CardTitle>
                        <CardDescription>Manage, Approve and Deny Overtimes</CardDescription>
                    </CardHeader>
                    <CardContent className='flex-grow'>
                        {(pendingOvertimesCount ?? 0) > 0 ? (
                            <p className='text-sm text-gray-600'>You have <span className='text-red-500 font-bold'>{pendingOvertimesCount}</span> overtime requests to approve or deny!</p>
                        ) : (
                            <p className='text-sm text-gray-600'>No pending overtime requests.</p>
                        )}
                    </CardContent>
                    <CardFooter className="mt-auto">
                        <Link href="/administrator/manageOvertimes" passHref legacyBehavior className="w-full">
                            <Button className="w-full" variant="admin">
                                Manage Overtime Requests
                            </Button>
                        </Link>
                    </CardFooter>
                </Card>
            </div>
        </div>
    )
}

export default AdminCards