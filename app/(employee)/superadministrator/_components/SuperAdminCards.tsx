import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import React from 'react'
import Link from 'next/link'
import CreateDesignationButton from './CreateDesignationButton'
import CreateDepartmentForm from './CreateDepartmentForm'
import { Calendar, DollarSign, Building2 } from 'lucide-react'

export default function SuperAdminCards() {
    return (
        <div className='flex flex-col gap-6'>
            <div className='mt-5'>
                <p className='font-bold text-4xl'>ACTIONS</p>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 pr-6">
                <CardLayout
                    isHidden
                    header='Departmental Actions'
                    description='Manage Departments'
                    icon={<Building2 className="h-6 w-6 text-primary" />}
                    buttonText=""
                    buttonLink=""
                >
                    <div className='space-y-4'>
                        <div className='grid grid-cols-2  items-center'>
                            <p className='text-sm font-medium'>Create Department</p>
                            <CreateDepartmentForm variant="superadmin" />
                        </div>
                        <div className='grid grid-cols-2  items-center'>
                            <p className='text-sm font-medium'>Create Designation</p>
                            <CreateDesignationButton variant="superadmin" />
                        </div>
                        <div className='grid grid-cols-2  items-center'>
                            <p className='text-sm font-medium'>View Departments</p>
                            <Link href='/superadministrator/departments'>
                                <Button className='w-full' variant={"superadmin"}>
                                    View Departments
                                </Button>
                            </Link>
                        </div>
                    </div>
                </CardLayout>

                <CardLayout
                    header='Attendance Panel'
                    description='Add Holidays, Check Attendances'
                    icon={<Calendar className="h-6 w-6 text-primary" />}
                    buttonText="View Attendance Panel"
                    buttonLink="/superadministrator/attendancePanel"
                >
                    <p className='text-sm'>Manage employee attendance and holidays efficiently. Keep track of work hours, overtime, and time-off requests all in one place.</p>
                </CardLayout>

                <CardLayout
                    header='Payroll Actions'
                    description='Generate Payroll'
                    icon={<DollarSign className="h-6 w-6 text-primary" />}
                    buttonText="View Payroll Panel"
                    buttonLink="/superadministrator/payrollPanel"
                >
                    <p className='text-sm'>Streamline payroll processes and generate reports. Automate salary calculations, tax deductions, and payment distributions with ease.</p>
                </CardLayout>
            </div>
        </div>
    )
}

interface CardLayoutProps {
    header: string;
    description: string;
    children?: React.ReactNode;
    icon?: React.ReactNode;
    buttonText: string;
    buttonLink: string;
    isHidden?: boolean; // Add the isHidden prop
}

function CardLayout({ header, description, children, icon, buttonText, buttonLink, isHidden }: CardLayoutProps) {
    return (
        <Card className='shadow-md hover:shadow-lg transition-shadow duration-300 flex flex-col h-full'>
            <CardHeader className=''>
                {icon && <div className="mb-4">{icon}</div>}
                <CardTitle>{header}</CardTitle>
                <CardDescription>{description}</CardDescription>
            </CardHeader>
            <CardContent className='flex-grow'>
                {children}
            </CardContent>
            <div className="mt-auto p-6 pt-0">
                <Link className={`w-full ${isHidden ? 'hidden' : ''}`} href={buttonLink}>
                    <Button variant="superadmin" className={`w-full ${isHidden ? 'hidden' : ''}`}>
                        {buttonText}
                    </Button>
                </Link>
            </div>
        </Card>
    );
}