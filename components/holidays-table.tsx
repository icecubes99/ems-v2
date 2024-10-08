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
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { cn } from '@/lib/utils'

interface HolidayTableProps {
    className?: string
}
export function HolidayTable({ className }: HolidayTableProps) {
    const { holidays, isLoading, error } = useHolidays()

    return (
        <Card className={cn("w-full", className)}>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                <CardTitle className="flex items-center gap-2">
                    Upcoming Holidays for {new Date().getFullYear()}
                </CardTitle>
                <Calendar className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
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
            </CardContent>
        </Card>
    )
}