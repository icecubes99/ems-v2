"use client"

import { Account, AddressLine, Department, Gender, Leaves, LeaveStatus, Status, TwoFactorConfirmation, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { ArrowUpDown, Edit, MoreHorizontal } from "lucide-react"
import { PayrollItemWithUser } from "@/types/types"
import { Button } from "@/components/ui/button"
import PayslipPDFButton from "@/app/(payslips)/payslips/_components/payslip-pdf-button"
import AddDeductionsFormCorrections from "./deductions-form-corrections"
import { useState } from "react"
import React from "react"
import AddAdditionalEarningsFormCorrection from "./additional-earnings-form-corrections"
import { RemoveEmployeeDialog } from "./delete-payroll-item"
import Link from "next/link"

export const columnsPayrollItems: ColumnDef<PayrollItemWithUser>[] = [
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
                        Payroll Range
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const startDate = new Date(row.getValue("createdAt"))
            const startDateFormatted = startDate.toDateString()

            const payStart = row.original.payroll.payPeriodStart
            const payPeriodStart = new Date(payStart)
            const startFormatted = payPeriodStart.toDateString()

            const payEnd = row.original.payroll.payPeriodEnd
            const payPeriodEnd = new Date(payEnd)
            const endFormatted = payPeriodEnd.toDateString()

            return <div className="py-2">{`${startFormatted} - ${endFormatted}`}</div>
        }
    },
    {
        accessorKey: "netSalary",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Net Salary
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const netSalary = row.original.netSalary;
            const formattedNetSalary = new Intl.NumberFormat('en-PH', {
                style: 'currency',
                currency: 'PHP'
            }).format(netSalary);

            return <div>{formattedNetSalary}</div>;
        }
    },

    {
        id: "Get PDF",
        header: "Payslip PDF",
        cell: ({ row }) => {
            const user = row.original
            return (
                <div className="grid grid-cols-1 gap-2">
                    <PayslipPDFButton payslip={row.original} />
                </div>
            )
        },
    },
    {
        id: "Edit",
        header: "Edit Details",
        cell: ({ row }) => {
            const user = row.original
            return (
                <div className="grid grid-cols-1 gap-2">
                    <Link href={`/superadministrator/payrollPanel/payroll/item/${user.id}`}>
                        <Button variant={"outline"}>
                            <Edit className="w-4 h-4" />
                        </Button>
                    </Link>
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
            const [isAddOpen, setIsAddOpen] = useState(false)
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
                                Copy ID
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />

                            <DropdownMenuItem onSelect={(event) => {
                                event.preventDefault()
                                setIsUpdateOpen(true)
                            }}>
                                Add Deduction
                            </DropdownMenuItem>

                            <DropdownMenuItem onSelect={(event) => {
                                event.preventDefault()
                                setIsAddOpen(true)
                            }}>
                                Add Addition
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem
                                onSelect={(event) => {
                                    event.preventDefault()
                                    setIsDeleteOpen(true)
                                }}
                            >
                                Remove Employee
                            </DropdownMenuItem>


                        </DropdownMenuContent>
                    </DropdownMenu>
                    <AddDeductionsFormCorrections userId={user.userId} variant={"superadmin"} payrollItemId={user.id} payrollId={user.payroll.id} isOpen={isUpdateOpen} onOpenChange={setIsUpdateOpen} />
                    <AddAdditionalEarningsFormCorrection userId={user.userId} variant={"superadmin"} payrollItemId={user.id} payrollId={user.payroll.id} isOpen={isAddOpen} onOpenChange={setIsAddOpen} />
                    <RemoveEmployeeDialog userId={user.userId} payrollId={user.payroll.id} isOpen={isDeleteOpen} onOpenChange={setIsDeleteOpen} variant={"destructive"} />
                </>
            )
        }
    }
]
