import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import Link from 'next/link'
import React from 'react'


const EmployeePageContent = () => {
    return (
        <div className='mt-5'>
            <p className='font-bold text-4xl'>EMPLOYEE MANAGEMENT</p>

            <div className='grid grid-cols-3 mt-5'>
                <Card>
                    <CardHeader className='items-center'>
                        <CardTitle>
                            Create Employee
                        </CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Link href={"/superadministrator/employeePanel/createEmployee"}>
                            <Button variant={"superadmin"} className='w-full'>
                                Create Employee
                            </Button>
                        </Link>
                    </CardContent>
                </Card>

            </div>
        </div>
    )
}

export default EmployeePageContent