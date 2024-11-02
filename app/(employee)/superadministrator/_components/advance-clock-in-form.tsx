"use client"
import React from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { AdvanceClockInSchema } from '@/schemas/attendance-index';
import { advanceClockIn } from '@/actions/superadmin/advance-clock-in';

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";

import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { CalendarPlus, Plus } from 'lucide-react';
import { MultiSelectUsers } from '@/components/ui/multi-select-components';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

export const AdvanceClockInForm = () => {
    const [error, setError] = useState<string | undefined>("")
    const [success, setSuccess] = useState<string | undefined>("")
    const [isPending, startTransition] = useTransition()
    const [open, setOpen] = useState(false)
    const [dateISO, setDateISO] = useState("")

    const form = useForm<z.infer<typeof AdvanceClockInSchema>>({
        resolver: zodResolver(AdvanceClockInSchema),
        defaultValues: {
            userIds: [],
            startDate: "",
            endDate: "",
            type: ""
        }
    });

    const onSubmit = (values: z.infer<typeof AdvanceClockInSchema>) => {
        setError("")
        setSuccess("")

        startTransition(() => {
            advanceClockIn(values)
                .then((data) => {
                    if (data.error) {
                        setError(data.error)
                    }

                    if (data.success) {
                        setSuccess(data.success)
                        setTimeout(() => {
                            window.location.reload()
                        }, 300)
                    }
                })
                .catch((error) => {
                    console.error("Advance Clock In Error:", error);
                    setError("An error occurred!");
                })
        })
    };

    const today = new Date().toISOString().split('T')[0];

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="outline" className="h-auto py-4 flex flex-col items-center justify-center">
                    <CalendarPlus className="w-6 h-6 mb-2" />
                    Generate Advanced Timesheets
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card>
                    <CardHeader>
                        <CardTitle>
                            Create Advanced Timesheets for Users
                        </CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6`'>
                                <FormField
                                    control={form.control}
                                    name='userIds'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Departments</FormLabel>
                                            <FormControl>
                                                <MultiSelectUsers
                                                    onChange={field.onChange} />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name='startDate'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Start Date</FormLabel>
                                            <FormControl>
                                                <input
                                                    type="date"
                                                    {...field}
                                                    id="start"
                                                    name="trip-start"
                                                    // min={today}
                                                    disabled={isPending}
                                                    className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                                                    onChange={(e) => {
                                                        field.onChange(e);
                                                        setDateISO(new Date(e.target.value).toISOString());
                                                    }}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name='endDate'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>End Date</FormLabel>
                                            <FormControl>
                                                <input
                                                    type="date"
                                                    {...field}
                                                    id="start"
                                                    name="trip-start"
                                                    min={today}
                                                    disabled={isPending}
                                                    className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                                                    onChange={(e) => {
                                                        field.onChange(e);
                                                        setDateISO(new Date(e.target.value).toISOString());
                                                    }}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name='type'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Type</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={field.onChange}
                                                defaultValue={field.value}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Pick the Type" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value={"Onsite"}>On-Site</SelectItem>
                                                    <SelectItem value={"Event"}>Event</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <div className='mt-4 gap-2 flex-col flex'>
                                    <FormError message={error} />
                                    <FormSucess message={success} />
                                    <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                                        Create Advance Timesheets
                                    </Button>
                                </div>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}