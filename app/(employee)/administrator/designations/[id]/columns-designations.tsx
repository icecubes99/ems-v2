"use client"

import { Account, AddressLine, AssignDesignation, Department, Gender, Status, TwoFactorConfirmation, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"
import { MoreHorizontal } from "lucide-react"
import { ArrowUpDown } from "lucide-react"

import { Button } from "@/components/ui/button"
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"


import { Badge } from "@/components/ui/badge"
import useUser from "@/hooks/use-user"
import { Skeleton } from "@/components/ui/skeleton"
import { AssignDesignationWithUser } from "@/types/types"

import { FilterFn } from "@tanstack/react-table"

import UpdateAssignedUserForm from "@/app/(employee)/superadministrator/_components/update-assigned-user-form"
import { RemoveUserDialog } from "@/app/(employee)/superadministrator/_components/remove-assigned-user"
// This type is used to define the shape of our data.
// You can use a Zod schema here if you want.

/**
 * THIS IS HOW TO CREATE RELATIONAL TABLES
 * FIRST IS TO CREATE A TYPE THAT WILL BE USED TO DEFINE THE SHAPE OF THE DATA
 * SECOND IS TO CHANGE YOUR API TO INCLUDE THE RELATED DATA
 * THIRD IS JUST CHANGE THE CELL TO GET THE INFORMATION FROM THE RELATED DATA
 */


export const columnsDesignation: ColumnDef<AssignDesignationWithUser>[] = [
    {
        accessorKey: "userId",
        header: ({ column }) => {
            return (
                <Button
                    variant="ghost"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
                >
                    Name
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </Button>
            )
        },
        cell: ({ row }) => {
            return <div>{row.original.user.firstName + " " + row.original.user.lastName || 'N/A'}</div>
        }
    },
    {
        id: "email",
        accessorFn: (row) => row.user.email,
        header: "Email",
        cell: ({ row }) => row.original.user.email || 'N/A',
        filterFn: (row, id, filterValue) => {
            return row.original.user.email?.toLowerCase().includes(filterValue.toLowerCase()) ?? false;
        },
    },
    {
        accessorKey: "employeeType",
        header: ({ column }) => {
            return (
                <Button
                    className="ml-"
                    variant="ghost"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
                >
                    Description
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </Button>
            )
        },
    },
    {
        id: "user.lastLogin",
        accessorKey: "user.lastLogin",
        header: ({ column }) => {
            return (
                <Button
                    variant="ghost"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
                >
                    Last Login
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </Button>
            )
        },
        cell: ({ row }) => {
            const date = new Date(row.getValue("user.lastLogin"))
            console.log(date)
            const formatted = date.toLocaleString()
            return <div>{formatted}</div>
        }
    },
    {
        accessorKey: "status",
        header: ({ column }) => {
            return (
                <Button
                    variant="ghost"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
                >
                    Status
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </Button>
            )
        },
        cell: ({ row }) => {
            if (row.original.status === Status.ACTIVE) {
                return (
                    <Badge variant={"sucess"}>Active</Badge>
                )
            } else if (row.original.status === Status.INACTIVE) {
                return <Badge variant={"destructive"}>Inactive</Badge>
            }
        }
    },
    {
        id: "actions",
        header: "Actions",
        cell: ({ row }) => {
            const user = row.original

            return (
                <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                        <Button variant="ghost" className="hidden h-8 w-8 p-0">
                            <span className="sr-only">Open menu</span>
                            <MoreHorizontal className="h-4 w-4" />
                        </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                        <DropdownMenuLabel>Actions</DropdownMenuLabel>
                        <DropdownMenuItem
                            onClick={() => navigator.clipboard.writeText(user.id)}
                        >
                            Copy User ID
                        </DropdownMenuItem>
                        <DropdownMenuSeparator />

                    </DropdownMenuContent>
                    <div className="flex w-full flex-col gap-2 p-2">
                        {/* <UpdateDepartmentForm departmentId={user.id} />
                        <ViewDepartmentButton departmentId={user.id} />
                        <CreateSpecificDesignationForm departmentId={user.id} /> */}
                        <UpdateAssignedUserForm variant={"admin"} assignedUserId={user.id} designationId={user.designationId} />
                        <RemoveUserDialog variant={"admin"} assignedUseId={user.id} />
                    </div>
                </DropdownMenu>

            )
        },
    },
]
