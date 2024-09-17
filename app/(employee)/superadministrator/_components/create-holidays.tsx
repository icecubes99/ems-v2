

"use client"
import React, { useEffect } from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { HolidaySchema } from '@/schemas/superadminIndex';
import { addHoliday } from '@/actions/superadmin/generate-working-days-and-months';

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';

const CreateHolidayCard = ({ className }: { className?: string }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [dateISO, setDateISO] = useState("")

    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof HolidaySchema>>({
        resolver: zodResolver(HolidaySchema),
        defaultValues: {
            name: "",
            date: ""
        }
    });

    const [open, setOpen] = useState(false);

    useEffect(() => {
        setOpen(false);
    }, []);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const onSubmit = (values: z.infer<typeof HolidaySchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            addHoliday(values)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }

                    if (data.success) {
                        setSuccess(data.success);
                        setOpen(false);
                        handleOpenChange(false);
                    }
                })
                .catch(() => setError("Error occurred"))
        })
    }

    return (

        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button className='w-full' variant={"superadmin"} size={"lg"}>Add Holiday</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card>
                    <CardHeader>
                        <CardTitle>Add Holiday</CardTitle>
                        <CardDescription>
                            Add a holiday to exclude from working days.
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <div className='space-y-4'>

                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='date'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Holiday Date</FormLabel>
                                                    <FormControl>
                                                        <input
                                                            type="date"
                                                            {...field}
                                                            id="start"
                                                            name="trip-start"
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
                                    </div>

                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='name'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Holiday Name</FormLabel>
                                                    <FormControl>
                                                        <Input
                                                            {...field}
                                                            disabled={isPending}
                                                            placeholder='Christmas Day'
                                                        />
                                                    </FormControl>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>

                                </div>
                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                                    Add Holiday
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>


    )
}

export default CreateHolidayCard;