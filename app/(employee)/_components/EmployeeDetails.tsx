import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import useUserAssignment from '@/hooks/use-current-assignment';
import { useCurrentUser, useCurrentUserId } from '@/hooks/use-current-user';
import { Address, ExtendedUser } from '@/next-auth';
import { EmployeeType, Status } from '@prisma/client';
import React, { useEffect, useState } from 'react'

interface EmployeeDetailsProps {
    user?: ExtendedUser;
    children?: React.ReactNode;
    designationName?: string;
    status?: string;
    employeeType?: string;

}
const EmployeeDetails = ({ children }: EmployeeDetailsProps) => {
    const user = useCurrentUser();
    const userId = useCurrentUserId() as string;

    const { status, employeeType, loading, designationName, error } = useUserAssignment(userId);

    const formatDate = (dateString?: string) => {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', { year: 'numeric', month: '2-digit', day: '2-digit' });
    };
    return (
        <div className='flex flex-col  gap-6'>
            <div className='mt-5 flex flex-col items-center justify-start'>
                <p className='font-bold text-4xl text-violet-950'>{user?.name}</p>

                <div className='text-sm mt-2'>
                    <div className='flex flex-row gap-2 items-center'>
                        <div className='text-sm text-purple-950 font-semibold'>
                            <Badge variant={"outline"} className='p-2'>
                                {loading ? "Loading..." : designationName || "No Designation"}
                            </Badge>
                        </div>
                        <div className='flex gap-2'>
                            {status === Status.ACTIVE ? (
                                <Badge className='p-2' variant={"outline"}>Active</Badge>
                            ) : (
                                <Badge className='p-2' variant={"destructive"}>Inactive</Badge>
                            )}
                            {employeeType === EmployeeType.REGULAR ? (
                                <Badge className='p-2' variant={"outline"}>Regular</Badge>
                            ) : employeeType === EmployeeType.CONTRACTUAL ? (
                                <Badge className='p-2' variant={"outline"}>Contractual</Badge>
                            ) : (
                                <Badge className='p-2' variant={"destructive"}>Probationary</Badge>
                            )}
                        </div>
                    </div>
                </div>
            </div>

            <div className='grid grid-cols-3 gap-8'>
                <Card className=' shadow-sm'>
                    <CardHeader>
                        <CardTitle>
                            PROFILE DETAILS
                        </CardTitle>
                        <CardDescription>This is You</CardDescription>
                    </CardHeader>
                    <CardContent className='space-y-4'>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>FIRST NAME:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {user?.firstName}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>MIDDLE NAME:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {user?.middleName}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>LAST NAME:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {user?.lastName}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>GENDER:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {user?.gender}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>DATE OF BIRTH:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {/* @ts-ignore */}
                                {formatDate(user?.birthDate)}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>JOB TITLE:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {user?.jobTitle}
                            </p>
                        </div>
                    </CardContent>
                    <CardFooter className='justify-end items-end'>
                    </CardFooter>
                </Card>
                {children}
            </div>
        </div>
    )
}

export default EmployeeDetails