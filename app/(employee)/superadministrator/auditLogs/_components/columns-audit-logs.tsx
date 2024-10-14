
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown, MoreHorizontal } from "lucide-react"
import { AuditLogWithUser, SalaryIncreaseEvent } from "@/types/types"
import React from 'react'
import { Badge } from "@/components/ui/badge"


export const columnsAuditLogs: ColumnDef<AuditLogWithUser>[] = [
    {
        accessorKey: "User",
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
            const userName = row.original.user.firstName + " " + row.original.user.lastName
            return <div className="py-2">
                {`${userName}`}
            </div>
        }
    },
    {
        accessorKey: "action",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Action
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
    },
    {
        accessorKey: "createdAt",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Date
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const createdAt = new Date(row.getValue("createdAt"))
            const formattedDate = createdAt.toUTCString()
            return <div className="py-2">
                <Badge variant={"outline"}>
                    {`${formattedDate}`}
                </Badge>
            </div>
        }
    },

]