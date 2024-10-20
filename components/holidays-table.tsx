// components/HolidayTable.tsx
"use client"

import { useHolidays } from '@/hooks/use-holidays'
import { format } from 'date-fns'
import { Calendar } from 'lucide-react'
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow
} from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"
import TableWrapper from './table-wrapper'
import { MdBeachAccess } from 'react-icons/md'

interface HolidayTableProps {
    className?: string
}
export function HolidayTable({ className }: HolidayTableProps) {
    const { holidays, isLoading, error } = useHolidays()

    return (
        <TableWrapper title='Holidays' description='List of Company Holidays' className={className} icon={<MdBeachAccess />}>
            <Table>
                <TableCaption>A list of holidays for the current year.</TableCaption>
                <TableHeader>
                    <TableRow>
                        <TableHead>Date</TableHead>
                        <TableHead>Holiday Name</TableHead>
                    </TableRow>
                </TableHeader>
                <TableBody>
                    {isLoading ? (
                        <TableRow>
                            <TableCell colSpan={2}>Loading holidays...</TableCell>
                        </TableRow>
                    ) : error ? (
                        <TableRow>
                            <TableCell colSpan={2}>Error: {error}</TableCell>
                        </TableRow>
                    ) : holidays?.length ? (
                        holidays.map((holiday) => (
                            <TableRow key={holiday.id}>
                                <TableCell>
                                    <Badge variant="outline">
                                        {format(new Date(holiday.date), 'MMMM d, yyyy')}
                                    </Badge>
                                </TableCell>
                                <TableCell>{holiday.name}</TableCell>
                            </TableRow>
                        ))
                    ) : (
                        <TableRow>
                            <TableCell colSpan={2}>No holidays available</TableCell>
                        </TableRow>
                    )}
                </TableBody>
            </Table>
        </TableWrapper>
    )
}