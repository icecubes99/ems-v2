"use client"

import { useState } from 'react'
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown, MoreHorizontal } from "lucide-react"
import { DeductionsWithUser } from "@/types/types"
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

export const columnsDeduction: ColumnDef<DeductionsWithUser>[] = [
    {
        accessorKey: "userId",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        User
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            return <div>{row.original.user.firstName + " " + row.original.user.lastName || 'N/A'}</div>
        }
    },
    {
        accessorKey: "deductionType",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Type
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
    },
    {
        accessorKey: "hiddenInfo",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Reason
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            return <div className="py-2">{`${row.original.description}`}</div>
        }
    },
    {
        accessorKey: "createdAt",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Created At
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const startDate = new Date(row.getValue("createdAt"))
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
            const formattedNetSalary = new Intl.NumberFormat('en-PH', {
                style: 'currency',
                currency: 'PHP'
            }).format(row.original.amount);

            return <div>{formattedNetSalary}</div>;
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
                                Copy Deduction ID
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem onSelect={(event) => {
                                event.preventDefault()
                                setIsUpdateOpen(true)
                            }}>
                                Update Deduction
                            </DropdownMenuItem>
                            <DropdownMenuItem onSelect={(event) => {
                                event.preventDefault()
                                setIsDeleteOpen(true)
                            }}>
                                Delete Deduction
                            </DropdownMenuItem>

                        </DropdownMenuContent>
                    </DropdownMenu>
                    <UpdateDeductionsForm
                        deductionId={user.id}
                        variant="superadmin"
                        isOpen={isUpdateOpen}
                        onOpenChange={setIsUpdateOpen}
                    />
                    <DeleteDeductionsDialog
                        variant="superadmin"
                        deductionsId={user.id}
                        isOpen={isDeleteOpen}
                        onOpenChange={setIsDeleteOpen}
                    />
                </>
            )
        },
    },
]