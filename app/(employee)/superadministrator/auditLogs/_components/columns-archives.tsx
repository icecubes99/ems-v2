"use client"

import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown } from "lucide-react"
import { Archive } from "@prisma/client"
import { Badge } from "@/components/ui/badge"

export const columnsArchives: ColumnDef<Archive>[] = [
    {
        accessorKey: "archiveType",
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
            return (
                <Badge variant="outline">
                    {row.original.archiveType}
                </Badge>
            )
        }
    },
    {
        accessorKey: "entityData",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Data
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            return <div
                className="mt-2 max-h-96 max-w-5xl overflow-auto bg-slate-100 text-md font-mono rounded-md">
                {JSON.stringify(row.original.entityData)}
            </div>
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
                        Archived At
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
        cell: ({ row }) => {
            const date = new Date(row.original.createdAt)
            return <div>{date.toLocaleString()}</div>
        }
    }
]