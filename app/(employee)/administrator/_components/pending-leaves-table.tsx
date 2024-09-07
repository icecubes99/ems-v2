"use client"

import { useOwnLeaves } from "@/hooks/use-own-leaves"
import { format } from "date-fns"
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
    TableFooter
} from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"
import { cn } from "@/lib/utils"
import { Calendar } from "lucide-react"
import { LeaveStatus } from "@prisma/client"
import { usePendingLeaves } from "@/hooks/use-pending-leaves"
import { ApproveLeaveDialog, RejectLeaveDialog } from "./update-pending-leaves-buttons"
import { useRemainingLeaves } from "@/hooks/use-remaining-leaves"


interface OwnLeavesTableProps {
    classname?: string
}

const PendingLeavesTable = ({ classname }: OwnLeavesTableProps) => {
    const { leaves, isLoading, error } = usePendingLeaves()

    return (
        <Table className={cn("w-full", classname)}>
            <TableHeader>
                <TableRow>
                    <TableHead>Date Range</TableHead>
                    <TableHead>Type</TableHead>
                    <TableHead>Reason</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Actions</TableHead>
                </TableRow>
            </TableHeader>
            <TableBody>
                {isLoading ? (
                    <TableRow>
                        <TableCell colSpan={4}>Loading leaves...</TableCell>
                    </TableRow>
                ) : error ? (
                    <TableRow>
                        <TableCell colSpan={4}>Error: {error}</TableCell>
                    </TableRow>
                ) : leaves?.length ? (
                    leaves.map((leave) => (
                        <TableRow key={leave.id}>
                            <TableCell className="p-5">
                                <div className="flex items-center space-x-2">
                                    <Calendar className="w-4 h-4 text-muted-foreground mr-2" />
                                    {format(new Date(leave.startDate), 'MMMM d, yyyy')} to {format(new Date(leave.endDate), 'MMMM d, yyyy')}
                                </div>
                            </TableCell>
                            <TableCell>{leave.leaveType}</TableCell>
                            <TableCell>{leave.reason}</TableCell>
                            <TableCell>
                                {leave.leaveStatus === LeaveStatus.APPROVED ? (
                                    <Badge variant="sucess">Approved</Badge>
                                ) : leave.leaveStatus === LeaveStatus.PENDING ? (
                                    <Badge variant="outline">Pending</Badge>
                                ) : (
                                    <Badge variant="destructive">Rejected</Badge>
                                )}
                            </TableCell>
                            <TableCell>
                                <div className="grid grid-cols-1 gap-2">
                                    <ApproveLeaveDialog leaveId={leave.id} />
                                    <RejectLeaveDialog leaveId={leave.id} />
                                </div>
                            </TableCell>
                        </TableRow>
                    ))
                ) : (
                    <TableRow>
                        <TableCell colSpan={4}>No leaves found.</TableCell>
                    </TableRow>
                )}
            </TableBody>
        </Table>
    )
}

export default PendingLeavesTable;