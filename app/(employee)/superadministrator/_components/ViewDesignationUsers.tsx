"use client"

import React from 'react'
import { Card, CardContent, CardHeader } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Button } from '@/components/ui/button'
import { Skeleton } from '@/components/ui/skeleton'

import useAssignedUsersInADesignation from '@/hooks/use-assigned-users-in-a-designation'
import { useUser } from '@/hooks/use-user'
import useDesignation from '@/hooks/use-designation'

interface ViewDesignationUsersProps {
    designationId: string
}

function UserRow({ userData }: { userData: { id: string; userId: string; employeeType: string; status: string } }) {
    const { user, loading } = useUser(userData.userId)

    return (
        <TableRow key={userData.id}>
            <TableCell>
                {loading ? (
                    <Skeleton className="h-4 w-full" />
                ) : (
                    user?.firstName + " " + user?.lastName || 'N/A'
                )}
            </TableCell>
            <TableCell>{userData.employeeType}</TableCell>
            <TableCell>
                <Badge variant={userData.status === 'ACTIVE' ? 'default' : 'secondary'}>
                    {userData.status}
                </Badge>
            </TableCell>
            <TableCell>
                <Button variant="outline" size="sm">View Details</Button>
            </TableCell>
        </TableRow>
    )
}

export default function ViewDesignationUsers({ designationId }: ViewDesignationUsersProps) {
    const { data: designationUsersData, loading: designationUsersLoading, error } = useAssignedUsersInADesignation(designationId)
    const { designation, loading } = useDesignation(designationId)


    if (designationUsersLoading || loading) {
        return (
            <Card className='mr-6'>
                <CardHeader>
                    <Skeleton className="h-9 w-1/6" />
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Name</TableHead>
                                <TableHead>Employee Type</TableHead>
                                <TableHead>Status</TableHead>
                                <TableHead>Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {designationUsersData && designationUsersData.map((userData) => (
                                <Skeleton className="h-4 w-full mt-4" key={userData.id} />
                            ))}
                        </TableBody>
                    </Table>
                </CardContent>
            </Card>
        )

    }

    if (error) {
        return <div aria-live="assertive">Error: {error}</div>
    }

    return (
        <Card className='mr-6'>
            <CardHeader>Users in this Designation {designation?.designationName}</CardHeader>
            <CardContent>
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>Name</TableHead>
                            <TableHead>Employee Type</TableHead>
                            <TableHead>Status</TableHead>
                            <TableHead>Actions</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {designationUsersData && designationUsersData.map((userData) => (
                            <UserRow key={userData.id} userData={userData} />
                        ))}
                    </TableBody>
                </Table>
            </CardContent>
        </Card>
    )
}