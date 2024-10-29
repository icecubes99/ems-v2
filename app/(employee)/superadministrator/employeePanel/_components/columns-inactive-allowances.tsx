"use client"

import { useState } from 'react'
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown, MoreHorizontal, Trash } from "lucide-react"
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { Button } from "@/components/ui/button"
import { Badge } from '@/components/ui/badge'
import Link from 'next/link'
import { Allowance } from '@prisma/client'
import { getUserById } from '@/data/user'
import useUser from '@/hooks/use-user'
import { RemoveAllowanceDialog, ToggleAllowanceInactive } from './allowances-toggle-dialog'

export const columnsInactiveAllowances: ColumnDef<Allowance>[] = [
    {
        accessorKey: "user",
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
            const userId = row.original.userId
            const { lastName, firstName } = useUser(userId)
            const fullName = `${firstName} ${lastName}`
            return (
                <>
                    <div>
                        {fullName}
                    </div>
                </>
            )
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
        cell: ({ row }) => {
            const type = row.original.type
            return (
                <>
                    <Badge variant={"destructive"}>
                        {type}
                    </Badge>
                </>
            )
        }
    },
    {
        accessorKey: "totalAmount",
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
        accessorKey: "period",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Period
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const payStart = row.original.startDate
            const payPeriodStart = new Date(payStart)
            const startFormatted = payPeriodStart.toDateString()

            const payEnd = row.original.endDate
            const payPeriodEnd = new Date(payEnd)
            const endFormatted = payPeriodEnd.toDateString()

            const today = new Date()
            if (today >= payPeriodEnd) {
                return <div className="text-red-500 font-bold">{`${startFormatted} - ${endFormatted} -> DONE`}</div>
            }


            return <div className="py-2">{`${startFormatted} - ${endFormatted}`}</div>
        }
    },
    {
        accessorKey: "Toggle",
        cell: ({ row }) => {
            const payEnd = row.original.endDate
            const payPeriodEnd = new Date(payEnd)
            const endFormatted = payPeriodEnd.toDateString()

            const today = new Date()
            const allowanceId = row.original.id
            if (today <= payPeriodEnd) {
                return <ToggleAllowanceInactive variant='inactive' allowanceId={allowanceId} />
            }
        }
    },
    {
        accessorKey: "Delete",
        cell: ({ row }) => {
            const allowanceId = row.original.id
            return (
                <RemoveAllowanceDialog allowanceId={allowanceId} />
            )
        }
    }
]