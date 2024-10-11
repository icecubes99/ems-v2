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

export const columnsPendingPayroll: ColumnDef<PayrollWithPayrollItems>[] = [
    {
        accessorKey: "id",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        ID
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
    },
    {
        accessorKey: "payrollStatus",
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
            const status = row.original.payrollStatus
            return (
                <>
                    <Badge variant={'outline'}>
                        {status}
                    </Badge>
                </>
            )
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
                        Payroll Period
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const payStart = row.original.payPeriodStart
            const payPeriodStart = new Date(payStart)
            const startFormatted = payPeriodStart.toDateString()

            const payEnd = row.original.payPeriodEnd
            const payPeriodEnd = new Date(payEnd)
            const endFormatted = payPeriodEnd.toDateString()

            return <div className="py-2">{`${startFormatted} - ${endFormatted}`}</div>
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
                        Total Amount
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const formattedNetSalary = new Intl.NumberFormat('en-PH', {
                style: 'currency',
                currency: 'PHP'
            }).format(row.original.totalAmount);

            return <div>{formattedNetSalary}</div>;
        }
    },
    {
        id: "actions",
        header: "Actions",
        cell: ({ row }) => {
            const user = row.original

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
                                Copy Earning ID
                            </DropdownMenuItem>

                            <DropdownMenuSeparator />

                            <Link href={`/superadministrator/payrollPanel/payroll/pending/${user.id}`}>
                                <DropdownMenuItem>
                                    View Payroll
                                </DropdownMenuItem>
                            </Link>


                        </DropdownMenuContent>
                    </DropdownMenu>
                </>
            )
        },
    },
]