import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import React from 'react'

import Link from 'next/link'
import CreateDesignationButton from './CreateDesignationButton'
import CreateDepartmentForm from './CreateDepartmentForm'


export default function SuperAdminCards() {
    return (
        <div className='flex flex-col gap-6'>
            <div className='mt-5'>
                <p className='font-bold text-4xl'>ACTIONS</p>
            </div>
            <div className="grid grid-cols-3 gap-8 pr-6">

                <CardLayout header='Departmental Actions' description='Manage Departments'>
                    <div className='flex flex-row items-center justify-between'>
                        <p className='text-sm font-medium'>Create Department</p>
                        <CreateDepartmentForm variant={"superadmin"} />
                    </div>
                    <div className='flex flex-row items-center  justify-between'>
                        <p className='text-sm font-medium'>View Departments</p>
                        <Button variant={"superadmin"}>
                            <Link href='/superadministrator/departments'>View Departments</Link>
                        </Button>
                    </div>
                    <div className='flex flex-row items-center justify-between'>
                        <p className='text-sm font-medium'>Create Designation</p>
                        <CreateDesignationButton variant={"superadmin"} />
                    </div>
                </CardLayout>

            </div>
        </div>
    )
}

function CardLayout({ header, description, children }: { header: string, description: string, children: React.ReactNode }) {
    return (
        <Card className='shadow-md'>
            <CardHeader>
                <CardTitle>
                    {header}
                </CardTitle>
                <CardDescription>
                    {description}
                </CardDescription>
            </CardHeader>
            <CardContent className='space-y-4'>
                {children}
            </CardContent>
        </Card>
    )
}

