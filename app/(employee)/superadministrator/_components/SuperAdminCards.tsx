import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader } from '@/components/ui/card'
import React from 'react'
import CreateDepartmentButton from './CreateDepartmentButton'

const SuperAdminCards = () => {
    return (
        <div className='flex flex-col gap-6'>
            <div className='mt-5'>
                <p className='font-bold text-4xl'>ACTIONS</p>
            </div>
            <div className="grid grid-cols-3 gap-8 pr-6">

                <Card className='shadow-sm'>
                    <CardHeader>
                        Departmental Actions
                        <CardDescription>
                            Manage Departments
                        </CardDescription>
                    </CardHeader>
                    <CardContent className='space-y-4'>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>Create Department</p>
                            <CreateDepartmentButton />
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>View Departments</p>
                            <Button>View</Button>
                        </div>
                    </CardContent>
                </Card>

            </div>
        </div>
    )
}

export default SuperAdminCards