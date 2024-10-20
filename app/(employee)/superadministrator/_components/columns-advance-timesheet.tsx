"use client"

import { useState } from 'react'
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown, MoreHorizontal } from "lucide-react"
import { AdvanceTimesheet, SalaryIncreaseEvent } from "@/types/types"
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
import React from 'react'
import useUser from '@/hooks/use-user'
import { UndoAdvanceTimesheetsDialog } from './undo-advance-timesheets-dialog'


export const columnsAdvanceTimesheet: ColumnDef<AdvanceTimesheet>[] = [
    {
        accessorKey: "Names",
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
            const departmentNames = row.original.users.map((item) => {
                const user = item.userId
                const { firstName, lastName } = useUser(user)
                return firstName + " " + lastName || ""
            })

            if (departmentNames.length > 0) {
                return <div>{`${departmentNames.join(', ')}`}</div>
            } else {
                return <div>No Name</div>
            }
        }
    },
    {
        accessorKey: "startDate",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Start Date
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const startDate = new Date(row.getValue("startDate"))
            const formattedDate = startDate.toLocaleDateString()
            return <div>{`${formattedDate}`}</div>
        }
    },
    {
        accessorKey: "endDate",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        End Date
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const endDate = new Date(row.getValue("endDate"))
            const formattedDate = endDate.toLocaleDateString()
            return <div>{`${formattedDate}`}</div>
        }
    },
    {
        accessorKey: "type",
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
                                Copy Salary Increase ID
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem onSelect={(event) => {
                                event.preventDefault()
                                setIsDeleteOpen(true)
                            }}>
                                Undo Advanced Timesheets
                            </DropdownMenuItem>

                        </DropdownMenuContent>
                    </DropdownMenu>
                    <UndoAdvanceTimesheetsDialog
                        id={user.id}
                        isOpen={isDeleteOpen}
                        onOpenChange={setIsDeleteOpen}
                    />
                </>
            )
        },
    },
]