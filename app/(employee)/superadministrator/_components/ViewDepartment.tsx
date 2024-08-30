'use client'

import React from 'react'
import useDesignationFromDepartment from '@/hooks/use-current-designationsFromDepartment'
import useDepartment from '@/hooks/use-department'
import { useUser } from '@/hooks/use-user'
import { Designation, Status } from '@prisma/client'
import { Card, CardContent, CardHeader } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import UpdateDesignationForm from './UpdateDesignationForm'
import CreateDesignationFormWithDept, { CreateSpecificDesignationFormButton } from './create-specific-designation-form'

interface ViewDepartmentProps {
    departmentId: string
}

export default function ViewDepartment({ departmentId }: ViewDepartmentProps) {
    const { data: designationData, loading: designationLoading, error } = useDesignationFromDepartment(departmentId)
    const { department, loading: departmentLoading } = useDepartment(departmentId)
    const { user: departmentHeadUser, loading: userLoading } = useUser(department?.departmentHeadUserId ?? '')

    if (departmentLoading || designationLoading || userLoading) {
        return <div aria-live="polite" aria-busy="true">Loading...</div>
    }

    if (error) {
        return <div aria-live="assertive">Error: {error}</div>
    }

    return (
        <Card className="min-w-[800px] max-w-[5000px]">
            <CardHeader className="text-lg font-semibold">
                {department?.departmentName} Department Details
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
                    <span>Loading...</span>
                ) : error ? (
                    <span>Error loading user</span>
                ) : (
                    `${user?.firstName ?? 'N/A'} ${user?.lastName ?? ''}`
                )}
            </TableCell>
            <TableCell>
                <div className='flex flex-col gap-2'>
                    <Button variant={"superadmin"}>View Designation</Button>
                    {/* <Dialog>
                        <DialogTrigger asChild>
                            <Button variant={"superadmin"}>Edit Designation</Button>
                        </DialogTrigger>
                        <DialogContent className='p-0 w-full bg-transparent border-none'>
                            <UpdateDesignationForm designationId={designation.id} />
                        </DialogContent>
                    </Dialog> */}
                    <UpdateDesignationForm designationId={designation.id} />
                </div>
            </TableCell>
        </TableRow>
    )
}