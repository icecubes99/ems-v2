"use client"

import { Account, AddressLine, Department, Gender, Leaves, LeaveStatus, OvertimeStatus, Status, TwoFactorConfirmation, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown } from "lucide-react"

import { Badge } from "@/components/ui/badge"
import { OvertimesWithUser } from "@/types/types"
import { ApproveOvertimeDialog, RejectOvertimeDialog } from "../_components/update-pending-overtimes-buttons"

// This type is used to define the shape of our data.
// You can use a Zod schema here if you want.


export const columnsPendingOvertimes: ColumnDef<OvertimesWithUser>[] = [
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
        accessorKey: "createdAt",
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
            const startDate = new Date(row.getValue("createdAt"))
            const startDateFormatted = startDate.toDateString()
            return <div className="py-2">{`${startDateFormatted}`}</div>
        }
    },
    {
        accessorKey: "overtimeType",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Overtime Type
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
        accessorKey: "status",
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
            if (row.original.status === OvertimeStatus.COMPLETED) {
                return (
                    <Badge variant={"sucess"}>Approved</Badge>
                )
            } else if (row.original.status === OvertimeStatus.REJECTED) {
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
                    {/* <ApproveLeaveDialog leaveId={user.id} />
                    <RejectLeaveDialog leaveId={user.id} /> */}
                    <ApproveOvertimeDialog overtimeId={user.id} />
                    <RejectOvertimeDialog overtimeId={user.id} />
                </div>
            )
        },
    },
]
