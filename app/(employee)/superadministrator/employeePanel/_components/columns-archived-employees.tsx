"use client"

import { Account, AddressLine, Gender, TwoFactorConfirmation, User, UserRole } from "@prisma/client"
import { ColumnDef } from "@tanstack/react-table"
import { Eye } from "lucide-react"
import { ArrowUpDown } from "lucide-react"

import { Button } from "@/components/ui/button"
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import Link from "next/link"


// This type is used to define the shape of our data.
// You can use a Zod schema here if you want.


export const columnsArchivedEmployeeList: ColumnDef<User>[] = [
    {
        accessorKey: "name",
        header: ({ column }) => {
            return (
                <Button
                    variant="ghost"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
                >
                    Name
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </Button>
            )
        },
    },
    {
        accessorKey: "email",
        header: ({ column }) => {
            return (
                <Button
                    variant="ghost"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
                >
                    Email
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </Button>
            )
        },
    },
    {
        id: "view",
        header: "View",
        cell: ({ row }) => {
            const user = row.original
            return <Link href={`employeePanel/user/${user.id}`}><Button variant={"outline"}><Eye className="h-4 w-4" /></Button></Link>
        }
    }
]
