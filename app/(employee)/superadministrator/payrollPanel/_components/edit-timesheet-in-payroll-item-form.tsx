"use client"

import React, { useState, useEffect } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'

import { editTimesheetInPayroll } from '@/actions/superadmin/edit-timesheet-in-payroll-item'
import { EditPayrollItemTimesheetSchema } from '@/schemas/payroll-index'

import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { FormError } from "@/components/form-error"
import { FormSucess } from "@/components/form-sucess"
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { Edit } from 'lucide-react'
import { useTimesheet } from '@/hooks/use-timesheets'

interface Props {
    timesheetId: string
}

export default function EditTimesheetInPayrollItemForm({ timesheetId }: Props) {
    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");
    const [isPending, setIsPending] = useState(false);
    const [open, setOpen] = useState(false);
    const [calculatedClockIn, setCalculatedClockIn] = useState("8:00 AM");
    const [calculatedClockOut, setCalculatedClockOut] = useState("6:00 PM");

    const { timesheet } = useTimesheet(timesheetId);

    const form = useForm<z.infer<typeof EditPayrollItemTimesheetSchema>>({
        resolver: zodResolver(EditPayrollItemTimesheetSchema),
        defaultValues: {
            isLate: false,
            minutesLate: 0,
            isOvertime: false,
            minutesOvertime: 0,
        }
    });

    useEffect(() => {
        if (timesheet) {
            form.reset(timesheet);
        }
    }, [timesheet, form]);

    const onSubmit = async (values: z.infer<typeof EditPayrollItemTimesheetSchema>) => {
        setError("")
        setSuccess("")
        setIsPending(true)

        try {
            const data = await editTimesheetInPayroll(timesheetId, values)
            if (data.error) {
                setError(data.error)
            }
            if (data.success) {
                setSuccess(data.success)
                setOpen(false)
                setTimeout(() => {
                    window.location.reload()
                }, 300)
            }
        } catch (error) {
            setError("An error occurred!")
        } finally {
            setIsPending(false)
        }
    };

    useEffect(() => {
        const subscription = form.watch((value, { name, type }) => {
            if (name === 'isLate' && type === 'change' && value.isLate === false) {
                form.setValue('minutesLate', 0);
            }
            if (name === 'isOvertime' && type === 'change' && value.isOvertime === false) {
                form.setValue('minutesOvertime', 0);
            }
        });
        return () => subscription.unsubscribe();
    }, [form]);

    useEffect(() => {
        const lateMinutes = form.watch("minutesLate");
        const overtimeMinutes = form.watch("minutesOvertime");

        if (form.watch("isLate")) {
            const newClockIn = new Date(2023, 0, 1, 8, lateMinutes);
            setCalculatedClockIn(newClockIn.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }));
        } else {
            setCalculatedClockIn("8:00 AM");
        }

        if (form.watch("isOvertime")) {
            const newClockOut = new Date(2023, 0, 1, 18, overtimeMinutes);
            setCalculatedClockOut(newClockOut.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }));
        } else {
            setCalculatedClockOut("6:00 PM");
        }
    }, [form.watch("minutesLate"), form.watch("minutesOvertime"), form.watch("isLate"), form.watch("isOvertime")]);

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="superadmin" className=""><Edit className='w-4 h-4' /></Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>Edit Timesheet</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name="isLate"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Is Late</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={(value) => {
                                                    const isLate = value === "true";
                                                    form.setValue("isLate", isLate);
                                                    if (!isLate) form.setValue("minutesLate", 0);
                                                }}
                                                value={field.value ? "true" : "false"}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Select True or False if Late" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value="true">True</SelectItem>
                                                    <SelectItem value="false">False</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="minutesLate"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Minutes Late</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending || !form.watch("isLate")}
                                                    type="number"
                                                    onChange={(e) => field.onChange(parseInt(e.target.value, 10))}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                {form.watch("isLate") && (
                                    <p className="text-sm text-muted-foreground mt-1">
                                        New clock-in time: {calculatedClockIn}
                                    </p>
                                )}

                                <FormField
                                    control={form.control}
                                    name="isOvertime"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Is Overtime</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={(value) => {
                                                    const isOvertime = value === "true";
                                                    form.setValue("isOvertime", isOvertime);
                                                    if (!isOvertime) form.setValue("minutesOvertime", 0);
                                                }}
                                                value={field.value ? "true" : "false"}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Select True or False if Overtime" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value="true">True</SelectItem>
                                                    <SelectItem value="false">False</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="minutesOvertime"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Minutes Overtime</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending || !form.watch("isOvertime")}
                                                    type="number"
                                                    onChange={(e) => field.onChange(parseInt(e.target.value, 10))}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                {form.watch("isOvertime") && (
                                    <p className="text-sm text-muted-foreground mt-1">
                                        New clock-out time: {calculatedClockOut}
                                    </p>
                                )}

                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                                    Edit Timesheet
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}