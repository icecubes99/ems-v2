"use client"

import { Account, AddressLine, Department, Gender, Leaves, LeaveStatus, Status, TwoFactorConfirmation, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"
import { MoreHorizontal } from "lucide-react"
import { ArrowUpDown } from "lucide-react"

import { Badge } from "@/components/ui/badge"
import { LeavesWithUser } from "@/types/types"
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu"
import { Button } from "@/components/ui/button"
import { ApproveLeaveDialog, RejectLeaveDialog } from "@/app/(employee)/administrator/_components/update-pending-leaves-buttons"

// This type is used to define the shape of our data.
// You can use a Zod schema here if you want.


export const columnsPendingLeaves: ColumnDef<LeavesWithUser>[] = [
    {
        accessorKey: "userId",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
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
        accessorKey: "startDate",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Date Range
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const startDate = new Date(row.getValue("startDate"))
            const endDateFormatted = row.original.endDate.toDateString()
            const startDateFormatted = startDate.toDateString()
            return <div className="py-2">{`${startDateFormatted} to ${endDateFormatted}`}</div>
        }
    },
    {
        accessorKey: "leaveType",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Leave Type
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
    },
    {
        accessorKey: "reason",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Reason
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            return <div className="w-40">{row.original.reason}</div>
        }
    },
    {
        accessorKey: "leaveStatus",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Status
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            if (row.original.leaveStatus === LeaveStatus.APPROVED) {
                return (
                    <Badge variant={"sucess"}>Approved</Badge>
                )
            } else if (row.original.leaveStatus === LeaveStatus.REJECTED) {
                return <Badge variant={"destructive"}>Rejected</Badge>
            } else {
                return <Badge variant={"outline"}>Pending</Badge>
            }
        }
    },


    {
        id: "actions",
        header: "Actions",
        cell: ({ row }) => {
            const user = row.original
            return (
                <div className="grid grid-cols-1 gap-2">
                    <ApproveLeaveDialog leaveId={user.id} />
                    <RejectLeaveDialog leaveId={user.id} />
                </div>
            )
        },
    },
]
