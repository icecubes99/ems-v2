import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardFooter, CardHeader } from '@/components/ui/card';
import { Address, ExtendedUser } from '@/next-auth';
import React, { useEffect, useState } from 'react'
import AddAddressButton from './_AddressComponents/AddAddressButton';
import AddressForm from '@/app/(employee)/_components/_AddressComponents/AddressForm';


interface EmployeeDetailsProps {
    user?: ExtendedUser;
    children?: React.ReactNode;
}
const EmployeeDetails = ({ user, children }: EmployeeDetailsProps) => {
    const formatDate = (dateString?: string) => {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', { year: 'numeric', month: '2-digit', day: '2-digit' });
    };

    return (
        <div className='flex flex-col  gap-6'>
            <div className='mt-5'>
                <p className='font-bold text-4xl'>{user?.name}</p>
            </div>

            <div className='grid grid-cols-3 gap-8 pr-6'>
                <Card className=' shadow-sm'>
                    <CardHeader>
                        PROFILE DETAILS
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
                            <p className='text-sm font-medium'>GENDER:</p>
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