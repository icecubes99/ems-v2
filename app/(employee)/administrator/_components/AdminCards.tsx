import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import React from 'react'
import Link from 'next/link'
import DesignationHeadCard from './designation-head-control-card'
import DepartmentHeadCard from './department-head-control-card'
import { PasswordsTable } from '@/components/passwords-table'
import { Users, FileText, Clock, Building, UserCircle } from 'lucide-react'
import { useLeavesPendingCount, useOvertimesPendingCount } from '@/hooks/use-ModelCounts'

interface AdminCardsProps {
    userId: string
}

const AdminCards = ({ userId }: AdminCardsProps) => {
    const { pendingLeavesCount } = useLeavesPendingCount()
    const { pendingOvertimesCount } = useOvertimesPendingCount()
    return (
        <div className='flex flex-col gap-6 mb-2'>
            <div className='mt-5'>
                <h1 className='font-bold text-4xl text-primary'>ACTIONS</h1>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 pr-6">

                <PasswordsTable classname='w-full row-span-3' />


                <Card>
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <UserCircle className="h-6 w-6" />
                            User Actions
                        </CardTitle>
                        <CardDescription>
                            User management and actions
                        </CardDescription>
                    </CardHeader>
                    <CardContent className='space-y-4'>
                        <div className='flex items-center justify-between'>
                            <p className='text-sm font-medium'>Employees List</p>
                            <Link href="/administrator/dataTable" passHref legacyBehavior>
                                <Button variant="admin">
                                    View Employees
                                </Button>
                            </Link>
                        </div>
                    </CardContent>
                </Card>

                <DesignationHeadCard userId={userId} />
                <DepartmentHeadCard userId={userId} />

                <Card>
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <FileText className="h-6 w-6" />
                            Leave Requests Panel
                        </CardTitle>
                        <CardDescription>Manage, Approve and Deny Requests</CardDescription>
                    </CardHeader>
                    <CardContent>
                        {(pendingLeavesCount ?? 0) > 0 ? (
                            <p className='text-sm text-gray-600'>You have <span className='text-red-500  font-bold'>{pendingLeavesCount}</span> leave requests to approve or deny!</p>
                        ) : (
                            <p></p>
                        )}
                    </CardContent>
                    <CardFooter>
                        <Link href="/administrator/manageLeaves" passHref legacyBehavior>
                            <Button className="w-full" variant="admin">
                                Manage Leave Requests
                            </Button>
                        </Link>
                    </CardFooter>
                </Card>

                <Card>
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <Clock className="h-6 w-6" />
                            Overtime Requests Panel
                        </CardTitle>
                        <CardDescription>Manage, Approve and Deny Overtimes</CardDescription>
                    </CardHeader>
                    <CardContent>
                        {(pendingOvertimesCount ?? 0) > 0 ? (
                            <p className='text-sm text-gray-600'>You have <span className='text-red-500  font-bold'>{pendingOvertimesCount}</span> overtime requests to approve or deny!</p>
                        ) : (
                            <p></p>
                        )}
                    </CardContent>
                    <CardFooter>
                        <Link href="/administrator/manageOvertimes" passHref legacyBehavior>
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