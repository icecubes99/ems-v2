'use client'

import React from 'react'
import useDesignationFromDepartment from '@/hooks/use-current-designationsFromDepartment'
import { useDepartment } from '@/hooks/use-department'
import { useUser } from '@/hooks/use-user'
import { Designation, Status } from '@prisma/client'
import { Card, CardContent, CardHeader } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Button } from '@/components/ui/button'
import UpdateDesignationForm from '../../superadministrator/_components/UpdateDesignationForm'
import Link from 'next/link'
import { Skeleton } from '@/components/ui/skeleton'

import CreateSpecificDesignationForm from '../../superadministrator/_components/create-specific-designation-form'

interface ViewDepartmentProps {
    departmentId: string
}

export default function ViewDepartment({ departmentId }: ViewDepartmentProps) {
    const { data: designationData, loading: designationLoading, error } = useDesignationFromDepartment(departmentId)
    const { department, loading: departmentLoading } = useDepartment(departmentId)
    const { user: departmentHeadUser, loading: userLoading } = useUser(department?.departmentHeadUserId ?? '')

    if (departmentLoading || designationLoading || userLoading) {
        return (
            <div className='min-w-[800px] max-w-[5000px] min-h-[800px]'>
                <Skeleton className="h-full w-full" />
            </div>
        )
    }

    if (error) {
        return <div aria-live="assertive">Error: {error}</div>
    }

    return (
        <Card className="min-w-[800px] max-w-[5000px]">
            <CardHeader className="text-lg font-semibold">
                <div className='flex flex-row justify-start items-center'>
                    {department?.departmentName} Department Details
                    <div className='ml-10'>
                        <CreateSpecificDesignationForm variant={"admin"} departmentId={departmentId} />
                    </div>
                </div>
            </CardHeader>
            <CardContent className="space-y-4">
                <DepartmentInfo label="Department Name" value={department?.departmentName} />
                <DepartmentInfo label="Description" value={department?.departmentDescription} />
                <DepartmentInfo
                    label="Status"
                    value={
                        department?.status === Status.ACTIVE ? (
                            <Badge variant="sucess">Active</Badge>
                        ) : (
                            <Badge variant="destructive">Inactive</Badge>
                        )
                    }
                />
                <DepartmentInfo
                    label="Head"
                    value={`${departmentHeadUser?.firstName} ${departmentHeadUser?.lastName}`}
                />
                <DesignationsTable departmentId={departmentId} designations={designationData ?? []} departmentName={department?.departmentName ?? ''} />
            </CardContent>
        </Card>
    )
}

function DepartmentInfo({ label, value }: { label: string; value: React.ReactNode }) {
    return (
        <div className="flex flex-row items-center justify-between">
            <p className="text-sm font-medium">{label}:</p>
            {typeof value === 'string' ? (
                <p className="text-md font-mono max-w-[250px] bg-slate-100 truncate p-1 rounded-md">{value}</p>
            ) : (
                value
            )}
        </div>
    )
}

function DesignationsTable({ designations, departmentName, departmentId }: { designations: Designation[]; departmentName: string, departmentId: string }) {
    if (designations.length === 0) {
        return <p>No designations found for this department.</p>
    }

    return (
        <div className="p-5 space-y-4">
            <p className="text-sm font-bold uppercase">{departmentName} DEPARTMENT DESIGNATIONS</p>
            <div className='max-h-96 overflow-y-auto'>
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>Designation Name</TableHead>
                            <TableHead>Designation Description</TableHead>
                            <TableHead>Designation Status</TableHead>
                            <TableHead>Designation Head</TableHead>
                            <TableHead>Actions</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {designations.map((designation) => (
                            <DesignationRow key={designation.id} designation={designation} />
                        ))}
                    </TableBody>
                </Table>
            </div>
        </div>
    )
}

function DesignationRow({ designation }: { designation: Designation }) {
    const { user, loading, error } = useUser(designation.designationHeadUserId)

    return (
        <TableRow>
            <TableCell>{designation.designationName}</TableCell>
            <TableCell>{designation.designationDescription}</TableCell>
            <TableCell>
                {designation.status === Status.ACTIVE ? (
                    <Badge variant="sucess">Active</Badge>
                ) : (
                    <Badge variant="destructive">Inactive</Badge>
                )}
            </TableCell>
            <TableCell>
                {loading ? (
                    <Skeleton className="h-4" />
                ) : error ? (
                    <span>Error loading user</span>
                ) : (
                    `${user?.firstName ?? 'N/A'} ${user?.lastName ?? ''}`
                )}
            </TableCell>
            <TableCell>
                <div className='flex flex-col gap-2'>
                    <Link className='h-4' href={`/administrator/designations/${designation.id}`} legacyBehavior passHref>
                        <Button variant={"admin"}>
                            View Designation
                        </Button>
                    </Link>
                    <UpdateDesignationForm variant={"admin"} designationId={designation.id} />
                </div>
            </TableCell>
        </TableRow>
    )
}