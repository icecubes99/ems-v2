"use client"

import { Account, AddressLine, Department, Gender, Leaves, LeaveStatus, Status, TwoFactorConfirmation, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"

import { ArrowUpDown } from "lucide-react"
import { PayrollItemWithUser } from "@/types/types"
import { Button } from "@/components/ui/button"
import { PayslipPDFButton } from "./payslip-pdf-button"


// This type is used to define the shape of our data.
// You can use a Zod schema here if you want.


export const columnsPayslips: ColumnDef<PayrollItemWithUser>[] = [
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
        id: "actions",
        header: "Actions",
        cell: ({ row }) => {
            const user = row.original
            return (
                <div className="grid grid-cols-1 gap-2">
                    {/* <Button variant={"auth"} >
                        View PDF
                    </Button> */}
                    <PayslipPDFButton payslip={row.original} />
                </div>
            )
        },
    },
]
