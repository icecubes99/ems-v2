"use client"
import React from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { createSpecialDay } from '@/actions/superadmin/create-special-day';
import { SpecialDaySchema } from '@/schemas/attendance-index';

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

export const CreateSpecialDayDialog = () => {
    const [error, setError] = useState<string | undefined>("")
    const [success, setSuccess] = useState<string | undefined>("")
    const [isPending, startTransition] = useTransition()
    const [open, setOpen] = useState(false)
    const [dateISO, setDateISO] = useState("")

    const form = useForm<z.infer<typeof SpecialDaySchema>>({
        resolver: zodResolver(SpecialDaySchema),
        defaultValues: {
            date: ""
        }
    });

    const onSubmit = (values: z.infer<typeof SpecialDaySchema>) => {
        setError("")
        setSuccess("")

        startTransition(() => {
            createSpecialDay(values)
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

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="outline" className="h-auto py-4 flex flex-col items-center justify-center">
                    <Plus className="w-6 h-6 mb-2" />
                    Add Special Working Day
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-[500px]'>
                    <CardHeader>
                        <CardTitle>
                            Create Special Day
                        </CardTitle>
                        <CardDescription>
                            Create a special day for the employees, this will be a day off for the employees and pays times 2 for the employees who work on this day.
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name='date'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Date</FormLabel>
                                            <FormControl>
                                                <input
                                                    type="date"
                                                    {...field}
                                                    id="date"
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
                                <div className='mt-4 gap-2 flex-col flex'>
                                    <FormError message={error} />
                                    <FormSucess message={success} />
                                    <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                                        Create Special Day
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