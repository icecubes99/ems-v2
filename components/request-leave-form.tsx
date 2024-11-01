"use client"

import React from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { LeaveRequestSchema } from '@/schemas/attendance-index';
import { requestLeave } from '@/actions/requestLeave';

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
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { LeaveType, Status } from '@prisma/client';
import { Dialog } from '@/components/ui/dialog';
import { DialogContent, DialogTrigger } from '@/components/RefreshDialog';
import { Textarea } from './ui/textarea';
import { Input } from './ui/input';

const RequestLeaveButton = () => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [dateISO, setDateISO] = useState("")

    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof LeaveRequestSchema>>({
        resolver: zodResolver(LeaveRequestSchema),
        defaultValues: {
            startDate: "",
            endDate: "",
            reason: "",
        }
    });

    const [open, setOpen] = useState(false);
    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }


    const onSubmit = (values: z.infer<typeof LeaveRequestSchema>) => {
        setError("")
        setSuccess("")

        const formData = new FormData()
        formData.append('startDate', values.startDate)
        formData.append('endDate', values.endDate)
        formData.append('reason', values.reason)
        formData.append('leaveType', values.leaveType)
        formData.append('document', values.document)


        startTransition(async () => {
            try {
                const result = await requestLeave(formData)
                if ('error' in result) {
                    setError(result.error)
                } else if ('success' in result) {
                    setSuccess(result.success)
                    setTimeout(() => {
                        setOpen(false)
                        window.location.reload()
                    }, 1000)
                }
            } catch (error) {
                setError("An error occurred while submitting your request")
            }
        })
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant={"auth"}>
                    Request Leave
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card>
                    <CardHeader>
                        <CardTitle>
                            Request Leave
                        </CardTitle>
                        <CardDescription>
                            You cannot edit or delete a leave request once it has been submitted.
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <div className='space-y-4'>


                                    <div>
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
                                            name="leaveType"
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Leave Type</FormLabel>
                                                    <Select
                                                        disabled={isPending}
                                                        onValueChange={field.onChange}
                                                        defaultValue={field.value}
                                                    >
                                                        <FormControl>
                                                            <SelectTrigger>
                                                                <SelectValue placeholder="Pick your Leave Type" />
                                                            </SelectTrigger>
                                                        </FormControl>
                                                        <SelectContent>
                                                            <SelectItem value={LeaveType.VACATION}>Vacation</SelectItem>
                                                            <SelectItem value={LeaveType.SICK}>Sick Leave</SelectItem>
                                                            <SelectItem value={LeaveType.MATERNITY}>Maternal Leave</SelectItem>
                                                            <SelectItem value={LeaveType.INCENTIVE}>Incentive</SelectItem>
                                                        </SelectContent>
                                                    </Select>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>

                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='reason'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Reason</FormLabel>
                                                    <FormControl>
                                                        <Textarea
                                                            {...field}
                                                            disabled={isPending}
                                                            placeholder=''
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
                                            name='document'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Choose a document</FormLabel>
                                                    <FormControl>
                                                        <Input
                                                            type="file"
                                                            accept=".pdf,.doc,.docx,.jpg,.jpeg,.png,.svg"
                                                            disabled={isPending}
                                                            onChange={(e) => {
                                                                const file = e.target.files?.[0]
                                                                if (file) {
                                                                    field.onChange(file)
                                                                }
                                                            }}
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
                                <Button variant={"auth"} disabled={isPending} type='submit' className='w-full'>
                                    Request Leave
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )

}
export default RequestLeaveButton;