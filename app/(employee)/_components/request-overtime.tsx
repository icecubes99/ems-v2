"use client"

import React from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { OvertimeSchema } from '@/schemas/attendance-index';
import { requestOvertime } from '@/actions/requestOvertime';

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
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { OvertimeType, Status } from '@prisma/client';
import { Dialog } from '@/components/ui/dialog';
import { DialogContent, DialogTrigger } from '@/components/RefreshDialog';
import { Textarea } from '@/components/ui/textarea';
import { OvertimeStatus, useOvertimeStatus } from '@/hooks/use-overtime-status';
import { Clock12, Clock6, Clock8 } from 'lucide-react';

const RequestOvertime = () => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const [isPending, startTransition] = useTransition();

    const { status, isLoading, refreshStatus } = useOvertimeStatus();

    const form = useForm<z.infer<typeof OvertimeSchema>>({
        resolver: zodResolver(OvertimeSchema),
        defaultValues: {
            reason: "",
        }
    });

    const [open, setOpen] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    };

    const onSubmit = (values: z.infer<typeof OvertimeSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            requestOvertime(values)
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
                .catch(() => setError("An error what!"));
        });
    };

    const getButtonText = (status: OvertimeStatus) => {
        switch (status) {
            case 'NOT_RECORDED':
                return "Record Overtime";
            case 'RECORDED':
                return "Overtime recorded"
            default:
                return "Log Overtime"
        }
    }

    return (
        <Dialog open={open} onOpenChange={handleOpenChange}>
            <DialogTrigger asChild>
                <Button
                    variant={"auth"}
                    disabled={isLoading || status === 'RECORDED'}
                    size={"lg"}
                >
                    <Clock8 className='h-4 w-4 mr-4' />
                    {isLoading ? "Loading..." : getButtonText(status)}
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <Card>
                    <CardHeader>
                        <CardTitle>
                            Record Overtime
                        </CardTitle>
                        <CardDescription>
                            Inout the reason for the overtime
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>

                                <div className='space-y-4'>


                                    <div>
                                        <FormField
                                            control={form.control}
                                            name="overtimeType"
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Gender</FormLabel>
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
                                                            <SelectItem value={OvertimeType.HOLIDAY}>Holiday Overtime</SelectItem>
                                                            <SelectItem value={OvertimeType.MANDATORY}>Mandatory Overtime</SelectItem>
                                                            <SelectItem value={OvertimeType.REGULAR}>Regular Overtime</SelectItem>
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
export default RequestOvertime;