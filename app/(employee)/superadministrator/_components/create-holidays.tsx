

"use client"
import React, { useEffect } from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { HolidaySchema } from '@/schemas/superadminIndex';
import { addHoliday, editHoliday, removeHoliday } from '@/actions/superadmin/generate-working-days-and-months';

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";
import {
    AlertDialog,
    AlertDialogAction,
    AlertDialogCancel,
    AlertDialogContent,
    AlertDialogDescription,
    AlertDialogFooter,
    AlertDialogHeader,
    AlertDialogTitle,
    AlertDialogTrigger,
} from "@/components/ui/alert-dialog";

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { useSpecificHoliday } from '@/hooks/use-holidays';
import { CgSpinner } from 'react-icons/cg';
import { useRouter } from 'next/navigation';

export const CreateHolidayCard = ({ className }: { className?: string }) => {
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

export const UpdateHolidayCard = ({ holidayId, className }: { className?: string, holidayId: string }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [dateISO, setDateISO] = useState("")
    const { holiday, isLoading } = useSpecificHoliday(holidayId);

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

    useEffect(() => {
        if (holiday) {
            const localeDateString = holiday.date.toLocaleDateString('en-CA');
            const parsedDate = new Date(localeDateString);
            const isoDateString = parsedDate.toISOString().split('T')[0];

            form.reset({
                ...holiday,
                date: isoDateString,
            });
        }
    }, [holiday, form]);

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
            editHoliday(holidayId, values)
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

    if (isLoading) {
        return <CgSpinner className='animate-spin' />
    }

    return (

        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button className='w-full' variant={"superadmin"}>Edit Holiday</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card>
                    <CardHeader>
                        <CardTitle>Update Holiday</CardTitle>
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
                                    Edit Holiday
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}

export const DeleteHolidayDialog = ({ holidayId }: { holidayId: string }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const { holiday } = useSpecificHoliday(holidayId);
    const [open, setOpen] = useState(false);
    const router = useRouter()

    const handleAction = async () => {
        setError("");
        setSuccess("");

        const result = await removeHoliday(holidayId);
        if (result.error) {
            console.error(result.error);
            setError(result.error);
        } else {
            console.log(result.success);
            setSuccess(result.success);
            setTimeout(() => {
                window.location.reload();
            }, 300);
        }
    };
    return (
        <AlertDialog open={open} onOpenChange={setOpen}>
            <AlertDialogTrigger asChild>
                <Button variant={"destructive"}>Delete</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to remove this Holiday?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will remove the holiday from the list of holidays and add a working day.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleAction} variant={"destructive"}>Delete</Button>
                </AlertDialogFooter>
                <div>
                    <FormError message={error} />
                    <FormSucess message={success} />
                </div>
            </AlertDialogContent>
        </AlertDialog>
    )
}