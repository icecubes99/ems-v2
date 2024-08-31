"use client"

import React, { useEffect, useState } from 'react';
import { getEmergencyContact } from '@/actions/getEmergencyContact';
import { Card, CardContent, CardDescription, CardFooter, CardHeader } from '@/components/ui/card';

import AddEmergencyContactButton from './AddEmergencyContactButton';
import { EmergencyContact } from '@prisma/client';
import EditEmergencyContactButton from './EditEmergencyContactButton';
import { Skeleton } from '@/components/ui/skeleton';

const EmergencyContactCard = ({ userId }: { userId: string }) => {
    const [emergencyContact, setEmergencyContact] = useState<EmergencyContact>();
    const [error, setError] = useState<string | undefined>("");
    const [loading, setLoading] = useState<boolean>(true);
    const [isMounted, setIsMounted] = useState<boolean>(false);

    useEffect(() => {
        setIsMounted(true);
        const fetchEmergencyContact = async () => {
            setLoading(true);
            const data = await getEmergencyContact(userId);
            if (data.error) {
                setError(data.error);
            } else {
                setEmergencyContact(data.data as EmergencyContact);
            }
            setLoading(false);
        };

        fetchEmergencyContact();

    }, [userId]);

    if (!isMounted) {
        return null; // Render nothing on the server
    }

    return (
        <Card>
            <CardHeader>
                Emergency Contact Information
                <CardDescription>
                    Your Designated Emergency Contact
                </CardDescription>
            </CardHeader>
            <CardContent className='space-y-4'>
                {loading ? (
                    <div className='flex flex-col gap-4'>
                        <Skeleton className="h-9" />
                        <Skeleton className="h-9" />
                        <Skeleton className="h-9" />
                        <Skeleton className="h-9" />
                        <Skeleton className="h-9" />


                    </div>
                ) : error ? (
                    <div className='flex flex-col gap-4'>
                        <p className='text-sm font font-medium'>{error}</p>
                    </div>
                ) : (
                    <>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>FIRST NAME:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {emergencyContact?.firstName}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>MIDDLE NAME:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {emergencyContact?.middleName}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>LAST NAME:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {emergencyContact?.lastName}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>RELATION:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {emergencyContact?.relationship}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>CONTACT NUMBER:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {emergencyContact?.contactNumber}
                            </p>
                        </div>
                        <div className='flex flex-row items-center justify-between'>
                            <p className='text-sm font-medium'>EMAIL ADDRESS:</p>
                            <p className='text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md'>
                                {emergencyContact?.emailAddress}
                            </p>
                        </div>
                    </>
                )}
            </CardContent>
            <CardFooter className='justify-end'>
                {loading ? (
                    <AddEmergencyContactButton />
                ) : error ? (
                    <AddEmergencyContactButton />
                ) : (
                    <EditEmergencyContactButton />
                )}
            </CardFooter>
        </Card>
    )
}
export default EmergencyContactCard;