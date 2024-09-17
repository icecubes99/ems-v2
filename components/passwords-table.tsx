"use client"

import { useAttendancePasswords } from "@/hooks/use-attendance-password"
import { format } from "date-fns"
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
import { cn } from "@/lib/utils"
import { Key, Users } from "lucide-react"


export function PasswordsTable({ classname }: { classname?: string }) {
    const { days, isLoading, error } = useAttendancePasswords()
    return (
        <Card className={cn("w-full", classname)}>
            <CardHeader>
                <CardTitle className="flex items-center gap-2">
                    <Key className="h-6 w-6" />
                    Upcoming Passwords for {new Date().getFullYear()}
                </CardTitle>
            </CardHeader>
            <CardContent>
                <Table>
                    <TableCaption>A list of passwords for the following days.</TableCaption>
                    <TableHeader>
                        <TableRow>
                            <TableHead>Date</TableHead>
                            <TableHead>Password</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {isLoading ? (
                            <TableRow>
                                <TableCell colSpan={2}>Loading passwords...</TableCell>
                            </TableRow>
                        ) : error ? (
                            <TableRow>
                                <TableCell colSpan={2}>Error: {error}</TableCell>
                            </TableRow>
                        ) : days?.length ? (
                            days.map((day) => (
                                <TableRow key={day.id}>
                                    <TableCell>
                                        <Badge variant="outline">
                                            {format(new Date(day.date), 'MMMM d, yyyy')}
                                        </Badge>
                                    </TableCell>
                                    <TableCell>{day.password}</TableCell>
                                </TableRow>
                            ))
                        ) : (
                            <TableRow>
                                <TableCell colSpan={2}>No passwords found.</TableCell>
                            </TableRow>
                        )}
                    </TableBody>
                </Table>
            </CardContent>
        </Card>
    )
}