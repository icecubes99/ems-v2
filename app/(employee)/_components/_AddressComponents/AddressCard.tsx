"use client"

import React, { useEffect, useState } from 'react';
import { getAddress } from '@/actions/readAddress';
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { MapPin, Building2, Shield } from 'lucide-react';
import { Skeleton } from '@/components/ui/skeleton';
import AddressForm from './AddressForm';
import EditAddressForm from './EditAddressForm';

const AddressCard = ({ userId }: { userId: string }) => {
    const [address, setAddress] = useState<any>(null);
    const [error, setError] = useState<string | undefined>("");
    const [loading, setLoading] = useState<boolean>(true);
    const [isMounted, setIsMounted] = useState<boolean>(false);

    useEffect(() => {
        setIsMounted(true);
        const fetchAddress = async () => {
            setLoading(true);
            const data = await getAddress(userId);
            if (data.error) {
                setError(data.error);
            } else {
                setAddress(data.data);
            }
            setLoading(false);
        };

        fetchAddress();
    }, [userId]);

    if (!isMounted) return null;

    return (
        <Card>
            <CardHeader className="flex flex-row items-center gap-4">
                <MapPin className="h-6 w-6 text-primary" />
                <CardTitle>Address Information</CardTitle>
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
                            No address information found
                        </div>
                        <AddressForm userId={userId} />
                    </div>
                ) : (
                    <>
                        <div>
                            <div className="text-sm font-medium text-muted-foreground">Street</div>
                            <div>{address?.street}</div>
                        </div>
                        <div>
                            <div className="text-sm font-medium text-muted-foreground">Barangay</div>
                            <div>{address?.barangay}</div>
                        </div>
                        <Separator />
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">City</div>
                                <div>{address?.city}</div>
                            </div>
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Province</div>
                                <div>{address?.province}</div>
                            </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Country</div>
                                <div>{address?.country}</div>
                            </div>
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">ZIP Code</div>
                                <div>{address?.zipCode}</div>
                            </div>
                        </div>
                    </>
                )}
            </CardContent>
            <CardFooter className='justify-end'>
                {loading ? (
                    <div></div>
                ) : error ? (
                    <div></div>
                ) : (
                    <EditAddressForm userId={userId} />
                )}
            </CardFooter>

        </Card>
    );
};

export default AddressCard;