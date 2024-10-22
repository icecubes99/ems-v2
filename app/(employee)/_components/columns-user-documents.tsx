
import { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown, Download, MoreHorizontal } from "lucide-react"
import { AuditLogWithUser, SalaryIncreaseEvent } from "@/types/types"
import React from 'react'
import { Badge } from "@/components/ui/badge"
import { Documents } from "@prisma/client"
import { Button } from "@/components/ui/button"
import Link from "next/link"


export const columnsUserDocuments: ColumnDef<Documents>[] = [
    {
        accessorKey: "documentType",
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
            const documentType = row.getValue("documentType")
            if (documentType === "PDF") {
                return <div className="py-2">
                    <Badge variant={"outline"}>
                        {`${documentType}`}
                    </Badge>
                </div>
            } else if (documentType === "Word" || documentType === "WordOpenXML") {
                return <div className="py-2">
                    <Badge variant={"cyan"}>
                        {`Word`}
                    </Badge>
                </div>
            } else if (documentType === "JPEG" || documentType === "PNG" || documentType === "SVG") {
                return <div className="py-2">
                    <Badge variant={"violet"}>
                        {`Image`}
                    </Badge>
                </div>
            } else {
                return <div className="py-2">
                    <Badge variant={"destructive"}>
                        {`Unknown`}
                    </Badge>
                </div>
            }
        },
    },
    {
        accessorKey: "documentName",
        header: ({ column }) => {
            return (
                <div
                    className="flex flex-row items-center hover:cursor-pointer"
                    onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}>
                    <p className="hover:bg-slate-100/90">
                        Name
                    </p>
                    <ArrowUpDown className="ml-2 h-4 w-4" />
                </div>
            )
        },
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
            return <div className="py-2">
                <Link href={documentLink} legacyBehavior>
                    <a target="_blank" rel="noopener noreferrer">
                        <Button variant={"default"} size={"lg"}>
                            <Download className="w-6 h-6 mr-2" />
                            View Document
                        </Button>
                    </a>
                </Link>
            </div>
        }
    },

]