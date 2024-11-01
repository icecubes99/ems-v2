"use client"

import { Account, AddressLine, Department, Gender, Leaves, LeaveStatus, Status, TwoFactorConfirmation, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"
import { Download, MoreHorizontal } from "lucide-react"
import { ArrowUpDown } from "lucide-react"

import { Badge } from "@/components/ui/badge"
import { LeavesWithUser } from "@/types/types"
import Link from "next/link"
import { Button } from "@/components/ui/button"

// This type is used to define the shape of our data.
// You can use a Zod schema here if you want.


export const columnsRemainingLeaves: ColumnDef<LeavesWithUser>[] = [
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
        accessorKey: "documentLink",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Link
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const documentLink = row.original.documentLink
            return < div className="" >
                <Link href={documentLink} legacyBehavior>
                    <a target="_blank" rel="noopener noreferrer">
                        <Button variant={"outline"} size={"lg"}>
                            <Download className="w-4 h-4 mr-2" />
                            View
                        </Button>
                    </a>
                </Link>
            </div >
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


    // {
    //     id: "actions",
    //     header: "Actions",
    //     cell: ({ row }) => {
    //         const user = row.original

    //         return (
    //             <DropdownMenu>
    //                 <DropdownMenuTrigger asChild>
    //                     <Button variant="ghost" className="hidden h-8 w-8 p-0">
    //                         <span className="sr-only">Open menu</span>
    //                         <MoreHorizontal className="h-4 w-4" />
    //                     </Button>
    //                 </DropdownMenuTrigger>
    //                 <DropdownMenuContent align="end">
    //                     <DropdownMenuLabel>Actions</DropdownMenuLabel>
    //                     <DropdownMenuItem
    //                         onClick={() => navigator.clipboard.writeText(user.id)}
    //                     >
    //                         Copy User ID
    //                     </DropdownMenuItem>
    //                     <DropdownMenuSeparator />

    //                 </DropdownMenuContent>
    //                 <div className="flex w-full flex-col gap-2 p-2">
    //                 </div>
    //             </DropdownMenu>

    //         )
    //     },
    // },
]
