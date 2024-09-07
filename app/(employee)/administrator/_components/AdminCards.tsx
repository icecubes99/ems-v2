import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
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
                        <div className='flex flex-row items-center justify-between'>
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


            </div>
        </div>
    )
}

export default AdminCards