"use client"

import { useState } from 'react'
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown, MoreHorizontal } from "lucide-react"
import { PayrollWithPayrollItems } from "@/types/types"
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
import { Badge } from '@/components/ui/badge'
import Link from 'next/link'
import { Holiday } from '@prisma/client'
import { DeleteHolidayDialog, UpdateHolidayCard } from './create-holidays'

export const columnsHolidays: ColumnDef<Holiday>[] = [
    {
        accessorKey: "date",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Status
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const status = row.original.date
            const formattedDate = new Date(status).toDateString()
            return (
                <>
                    <Badge variant={'outline'}>
                        {formattedDate}
                    </Badge>
                </>
            )
        }
    },
    {
        accessorKey: "name",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Total Amount
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
    },
    {
        id: "actions",
        header: "Update",
        cell: ({ row }) => {
            const holiday = row.original

            return (
                <>
                    <UpdateHolidayCard holidayId={holiday.id} />
                </>
            )
        },
    },
    {
        id: "actions",
        header: "Delete",
        cell: ({ row }) => {
            const holiday = row.original

            return (
                <>
                    <DeleteHolidayDialog holidayId={holiday.id} />
                </>
            )
        },
    },
]