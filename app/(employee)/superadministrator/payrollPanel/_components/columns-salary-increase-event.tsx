"use client"

import { useState } from 'react'
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown, MoreHorizontal } from "lucide-react"
import { SalaryIncreaseEvent } from "@/types/types"
import UpdateDeductionsForm from "@/app/(employee)/administrator/_components/update-deductions-form"
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { Button } from "@/components/ui/button"
import { DeleteDeductionsDialog } from '@/app/(employee)/administrator/_components/delete-deductions-dialog'
import React from 'react'
import { useDepartment } from '@/hooks/use-department'
import { Badge } from '@/components/ui/badge'
import { UndoSalaryIncreaseDialog } from './undo-salary-increase'
import { useDesignation } from '@/hooks/use-designation'


export const columnsSalaryIncreaseEvent: ColumnDef<SalaryIncreaseEvent>[] = [
    {
        accessorKey: "Department",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Department
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const departmentNames = row.original.departments.map((department) => {
                const dept = department.departmentId
                const { department: deptLOL } = useDepartment(dept)
                return deptLOL?.departmentName || ""
            })

            const designationDepartmentNames = row.original.designations.map((designations) => {
                const desig = designations.designationId
                const { designation: desigLOL } = useDesignation(desig)
                const desigDeptId = desigLOL?.departmentId
                const { department: desigDept } = useDepartment(desigDeptId || "")
                return desigDept?.departmentName || ""
            })

            const uniqueDepartmentNames = Array.from(new Set([...departmentNames, ...designationDepartmentNames])).filter(Boolean)
            if (uniqueDepartmentNames.length > 0) {
                return <div>{`${uniqueDepartmentNames.join(', ')}`}</div>
            } else {
                return <div>No Department Name</div>
            }
        }
    },
    {
        accessorKey: "Designation",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Designation
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const designationNames = row.original.designations.map((designation) => {
                const desig = designation.designationId
                const { designation: desigLOL } = useDesignation(desig)
                return desigLOL?.designationName || ""
            }).filter(Boolean) // Filter out empty strings

            if (designationNames.length === 0) {
                return (
                    <div>
                        <Badge variant={"cyan"}>
                            All Designations
                        </Badge>
                    </div>
                )
            } else {
                return (
                    <div className=" flex flex-row gap-2 flex-wrap">
                        {designationNames.map((designationName, index) => (
                            <Badge key={index} variant={"default"}>
                                {designationName}
                            </Badge>
                        ))}
                    </div>
                )
            }
        }
    },
    {
        accessorKey: "appliedAt",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Applied At
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const startDate = new Date(row.getValue("appliedAt"))
            const formattedDate = startDate.toLocaleDateString()
            return <div className="py-2">{`${formattedDate}`}</div>
        }
    },
    {
        accessorKey: "amount",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Amount
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const amount = row.original.amount;
            const formattedNetSalary = amount != null ? new Intl.NumberFormat('en-PH', {
                style: 'currency',
                currency: 'PHP'
            }).format(amount) : "-";

            return <div>{formattedNetSalary}</div>;
        }
    },
    {
        accessorKey: "percentage",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Percentage
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const percentage = row.original.percentage;
            const formattedPercentage = percentage != null ? new Intl.NumberFormat('en-PH', {
                style: 'percent',
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(percentage / 100) : "-";

            return <div>{formattedPercentage}</div>;
        }
    },
    {
        id: "actions",
        header: "Actions",
        cell: ({ row }) => {
            const user = row.original
            const [isUpdateOpen, setIsUpdateOpen] = useState(false)
            const [isDeleteOpen, setIsDeleteOpen] = useState(false)

            return (
                <>
                    <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                            <Button variant="ghost" className="h-8 w-8 p-0">
                                <span className="sr-only">Open menu</span>
                                <MoreHorizontal className="h-4 w-4" />
                            </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                            <DropdownMenuLabel>Actions</DropdownMenuLabel>
                            <DropdownMenuItem
                                onClick={() => navigator.clipboard.writeText(user.id)}
                            >
                                Copy Salary Change ID
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem onSelect={(event) => {
                                event.preventDefault()
                                setIsDeleteOpen(true)
                            }}>
                                Undo Salary Change
                            </DropdownMenuItem>

                        </DropdownMenuContent>
                    </DropdownMenu>
                    <UndoSalaryIncreaseDialog
                        salaryIncreaseId={user.id}
                        isOpen={isDeleteOpen}
                        onOpenChange={setIsDeleteOpen}
                    />
                </>
            )
        },
    },
]