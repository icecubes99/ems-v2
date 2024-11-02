import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import useUserAssignment from '@/hooks/use-current-assignment';
import { useCurrentUser, useCurrentUserId } from '@/hooks/use-current-user';
import useUser from '@/hooks/use-user';
import { Address, ExtendedUser } from '@/next-auth';
import { EmployeeType, Status, UserRole } from '@prisma/client';
import { Separator } from '@/components/ui/separator';
import { User } from 'lucide-react';
import React, { useEffect, useState } from 'react'

interface EmployeeDetailsProps {
    userId: string
    children?: React.ReactNode;
}
const EmployeeDetailsV2 = ({ children, userId }: EmployeeDetailsProps) => {

    const user = useUser(userId);

    const { status, employeeType, loading, designationName, error } = useUserAssignment(userId);


    const formatDate = (dateInput?: Date | string) => {
        if (!dateInput) return '';
        const date = typeof dateInput === 'string' ? new Date(dateInput) : dateInput;
        return date.toLocaleDateString('en-US', { year: 'numeric', month: '2-digit', day: '2-digit' });
    };

    return (
        <div className='flex flex-col  gap-6'>
            <div className='mt-5 flex flex-col items-center justify-start'>
                <p className='font-bold text-4xl text-violet-950'>{`${user?.firstName} ${user.middleName} ${user.lastName}`}</p>

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
                            {user.role === UserRole.ADMIN ? (
                                <Badge className='p-2' variant={"cyan"}>Admin</Badge>
                            ) : user.role === UserRole.SUPERADMIN ? (
                                <Badge className='p-2' variant={"violet"}>Super Admin</Badge>
                            ) : (
                                <Badge className='p-2' variant={"outline"}>User</Badge>
                            )
                            }
                        </div>
                    </div>
                </div>
            </div>

            <div className='grid grid-cols-3 gap-8 '>
                <Card>
                    <CardHeader className="flex flex-row items-center gap-4">
                        <User className="h-6 w-6 text-primary" />
                        <CardTitle>Profile Information</CardTitle>
                    </CardHeader>
                    <CardContent className="grid gap-4">
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">First Name</div>
                                <div>{user?.firstName}</div>
                            </div>
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Last Name</div>
                                <div>{user?.lastName}</div>
                            </div>
                        </div>
                        <div>
                            <div className="text-sm font-medium text-muted-foreground">Middle Name</div>
                            <div>{user?.middleName}</div>
                        </div>
                        <Separator />
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Gender</div>
                                <div>{user?.gender}</div>
                            </div>
                            <div>
                                <div className="text-sm font-medium text-muted-foreground">Date of Birth</div>
                                <div>{formatDate(user?.dateOfBirth ?? undefined)}</div>
                            </div>
                        </div>
                        <div>
                            <div className="text-sm font-medium text-muted-foreground">Job Title</div>
                            <div>{user?.jobTitle}</div>
                        </div>
                    </CardContent>
                </Card>
                {children}
            </div>
        </div>
    )
}

export default EmployeeDetailsV2