import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import React from 'react'

import Link from 'next/link'
import CreateDesignationButton from './CreateDesignationButton'
import CreateDepartmentForm from './CreateDepartmentForm'
import CreateHolidaysCard from './create-holidays'


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
                        <Link href='/superadministrator/departments'>
                            <Button variant={"superadmin"}>
                                View Departments
                            </Button>
                        </Link>
                    </div>
                    <div className='flex flex-row items-center justify-between'>
                        <p className='text-sm font-medium'>Create Designation</p>
                        <CreateDesignationButton variant={"superadmin"} />
                    </div>
                </CardLayout>

                <CardLayout header='Attendance Panel' description='Add Holidays, Check Attendances'
                    footer={
                        <Link className='w-full' href={"/superadministrator/attendancePanel"}>
                            <Button className='w-full'>
                                View Attendance Panel
                            </Button>
                        </Link>
                    }>
                </CardLayout>
            </div>
        </div>
    )
}
interface CardLayoutProps {
    header: string
    description: string
    children?: React.ReactNode
    footer?: React.ReactNode
}

function CardLayout({ header, description, children, footer }: CardLayoutProps) {
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
            <CardFooter>
                {footer}
            </CardFooter>
        </Card>
    )
}

