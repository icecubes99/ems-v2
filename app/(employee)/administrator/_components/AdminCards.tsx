import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader } from '@/components/ui/card'
import React from 'react'
import Link from 'next/link'

const AdminCards = () => {
    return (
        <div className='flex flex-col gap-6'>
            <div className='mt-5'>
                <p className='font-bold text-4xl'>ACTIONS</p>
            </div>
            <div className="grid grid-cols-3 gap-8 pr-6">

                <Card className='shadow-sm'>
                    <CardHeader>
                        User Actions
                        <CardDescription>
                            User management and actions
                        </CardDescription>
                    </CardHeader>
                    <CardContent className='space-y-4'>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>Employees List</p>
                            <Button variant={"admin"} asChild>
                                <Link href={"/administrator/dataTable"}>
                                    View Employees
                                </Link>
                            </Button>
                        </div>
                    </CardContent>
                </Card>

                <Card className='shadow-sm'>
                    <CardHeader>
                        Designation Actions
                        <CardDescription>
                            Manage Designation details and actions
                        </CardDescription>
                    </CardHeader>
                    <CardContent className='space-y-4'>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>Designation List</p>
                            <Button variant={"admin"} asChild>
                                <Link href={"/administrator"}>
                                    View Designation
                                </Link>
                            </Button>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>Designation List</p>
                            <Button variant={"admin"} asChild>
                                <Link href={"/administrator"}>
                                    View Designation
                                </Link>
                            </Button>
                        </div>
                    </CardContent>
                </Card>

            </div>
        </div>
    )
}

export default AdminCards