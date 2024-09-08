import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import React from 'react'
import Link from 'next/link'
import DesignationHeadCard from './designation-head-control-card'
import DepartmentHeadCard from './department-head-control-card'
import { PasswordsTable } from '@/components/passwords-table'

interface AdminCardsProps {
    userId: string
}
const AdminCards = ({ userId }: AdminCardsProps) => {
    return (
        <div className='flex flex-col gap-6 mb-2'>
            <div className='mt-5'>
                <p className='font-bold text-4xl'>ACTIONS</p>
            </div>
            <div className="grid grid-cols-3 gap-8 pr-6">

                <Card className='shadow-sm'>
                    <CardHeader>
                        <CardTitle>
                            User Actions
                        </CardTitle>
                        <CardDescription>
                            User management and actions
                        </CardDescription>
                    </CardHeader>
                    <CardContent className='space-y-4'>
                        <div className='grid grid-cols-2  items-center justify-between'>
                            <p className='text-sm font-medium'>Employees List</p>
                            <Link href={"/administrator/dataTable"} passHref legacyBehavior>
                                <Button variant={"admin"}>
                                    View Employees
                                </Button>
                            </Link>
                        </div>
                    </CardContent>
                </Card>

                <DesignationHeadCard userId={userId} />
                <DepartmentHeadCard userId={userId} />
                <PasswordsTable classname='row-span-3' />

                <Card>
                    <CardHeader>
                        <CardTitle>Leave Requests Panel</CardTitle>
                        <CardDescription>Manage, Approve and Deny Requests</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <p>Manage Leave Request</p>
                    </CardContent>
                    <CardFooter>
                        <Link href={`/administrator/manageLeaves`} passHref legacyBehavior>
                            <Button className="w-full" variant="admin">
                                Manage Leave Requests
                            </Button>
                        </Link>
                    </CardFooter>
                </Card>
            </div>
        </div>
    )
}

export default AdminCards