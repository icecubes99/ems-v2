"use client"

import React, { useEffect, useState } from 'react';
import { getEmergencyContact } from '@/actions/getEmergencyContact';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { Phone, User, Shield } from 'lucide-react';
import { Skeleton } from '@/components/ui/skeleton';
import { EmergencyContact } from '@prisma/client';
import EditEmergencyContactButton from './EditEmergencyContactButton';
import AddEmergencyContactButton from './AddEmergencyContactButton';

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

    if (!isMounted) return null;

    return (
        <Card>
            <CardHeader className="flex flex-row items-center gap-4">
                <Phone className="h-6 w-6 text-primary" />
                <CardTitle>Emergency Contact</CardTitle>
            </CardHeader>
            <CardContent className="grid gap-4">
                {loading ? (
                    <div className='flex flex-col gap-4'>
                        <Skeleton className="h-9" />
                        <Skeleton className="h-9" />
                        <Skeleton className="h-9" />
                        <Skeleton className="h-9" />
                    </div>
                ) : error ? (
                    <div className="flex flex-col items-center justify-center gap-4 py-8">
                        <Shield className="h-12 w-12 text-muted-foreground" />
                        <div className="text-center text-sm text-muted-foreground">
                            No emergency contact found
                        </div>
                        <AddEmergencyContactButton userId={userId} />
                    </div>
                ) : (
                    <>
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">First Name</div>
                                <div>{emergencyContact?.firstName}</div>
                            </div>
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Last Name</div>
                                <div>{emergencyContact?.lastName}</div>
                            </div>
                        </div>
                        <div>
                            <div className="text-sm font-medium text-muted-foreground">Middle Name</div>
                            <div>{emergencyContact?.middleName}</div>
                        </div>
                        <Separator />
                        <div>
                            <div className="text-sm font-medium text-muted-foreground">Relationship</div>
                            <div>{emergencyContact?.relationship}</div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Contact Number</div>
                                <div>{emergencyContact?.contactNumber}</div>
                            </div>
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Email Address</div>
                                <div>{emergencyContact?.emailAddress}</div>
                            </div>
                        </div>
                        <EditEmergencyContactButton userId={userId} />
                    </>
                )}
            </CardContent>
        </Card>
    );
}

export default EmergencyContactCard;