"use client"

import { Account, AddressLine, Department, Gender, Leaves, LeaveStatus, Status, Timesheet, TwoFactorConfirmation, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"

import { ArrowUpDown, Check, X } from "lucide-react"
import { PayrollItemWithUser } from "@/types/types"
import { Button } from "@/components/ui/button"
import { useWorkingDay } from "@/hooks/use-working-days"
import { RemovePayrollItemTimesheet } from "./remove-payroll-item-timesheet"


export const columnsPayslipItemTimesheets: ColumnDef<Timesheet>[] = [
    {
        accessorKey: "day",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Day
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const workDayId = row.original.dayId
            const { workingDay } = useWorkingDay(workDayId)
            const workingDate = workingDay?.date.toDateString()
            return <div>{workingDate}</div>
        }
    },
    {
        accessorKey: "isLate",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Late
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const isLate = row.original.isLate
            if (isLate) {
                return <Check className="h-4 w-4 text-red-500" />
            } else {
                return <X className="h-4 w-4 text-green-500" />
            }
        }
    },
    {
        accessorKey: "isOvertime",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Overtime
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const isLate = row.original.isOvertime
            if (isLate) {
                return <Check className="h-4 w-4 text-green-500" />
            } else {
                return <X className="h-4 w-4 text-red-500" />
            }
        }
    },
    {
        accessorKey: "minutesOvertime",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Overtime Mins
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
    },
    {
        accessorKey: "minutesLate",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center  hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className=" hover:bg-slate-100/90">
                        Late Mins
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
    },
    {
        accessorKey: "Edit",
        header: ({ column }) => {
            return (
                <p className=" hover:bg-slate-100/90">
                    Edit
                </p>
            )
        },
        cell: ({ row }) => {
            return <Button>Edit</Button>
        }
    },
    {
        accessorKey: "Delete",
        header: ({ column }) => {
            return (
                <p className=" hover:bg-slate-100/90">
                    Delete
                </p>
            )
        },
        cell: ({ row }) => {
            const id = row.original.id
            return <RemovePayrollItemTimesheet timesheetId={id} />
        }
    },
]

