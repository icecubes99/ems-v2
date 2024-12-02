"use client"

import React, { useState, useTransition } from 'react';
import * as z from 'zod';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { FiEye, FiEyeOff } from "react-icons/fi";

import { Button } from "@/components/ui/button";
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { logTimesheet } from '@/actions/log-timesheet';

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";
import { TimesheetSchema } from '@/schemas/attendance-index';
import { FormError } from './form-error';
import { FormSucess } from './form-sucess';
import { cn } from '@/lib/utils';
import { CalendarClock } from 'lucide-react';
import { useTimesheetStatus, TimesheetStatus } from '@/hooks/use-timesheet-status';

export function TimesheetDialog({ classname }: { classname: string }) {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();
    const [open, setOpen] = useState(false);
    const [showPassword, setShowPassword] = useState(false);
    const { status, isLoading, refreshStatus } = useTimesheetStatus();

    const form = useForm<z.infer<typeof TimesheetSchema>>({
        resolver: zodResolver(TimesheetSchema),
        defaultValues: {
            password: ""
        }
    });

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            form.reset();
            setError("");
            setSuccess("");
        }
    };

    const onSubmit = (values: z.infer<typeof TimesheetSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            logTimesheet({ ...values, isClockingIn: status === 'NOT_CLOCKED_IN' })
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }

                    if (data.success) {
                        setSuccess(data.success);
                        setOpen(false);
                        refreshStatus();
                    }
                })
                .catch(() => setError("An unexpected error occurred"));
        });
    };

    const getButtonText = (status: TimesheetStatus) => {
        switch (status) {
            case 'NOT_CLOCKED_IN':
                return "Clock In";
            case 'CLOCKED_IN':
                return "Clock Out";
            case 'CLOCKED_OUT':
                return "Timesheet Logged";
            default:
                return "Log Timesheet";
        }
    };

    return (
        <Dialog open={open} onOpenChange={handleOpenChange}>
            <DialogTrigger asChild>
                <Button
                    size={"lg"}
                    className={cn("h-auto w-full py-4 flex flex-col items-center justify-center", classname)}
                    variant="auth"
                    disabled={isLoading || status === 'CLOCKED_OUT'}
                >
                    <CalendarClock className="w-6 h-6 mb-2" />
                    {isLoading ? "Loading..." : getButtonText(status)}
                </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px]">
                <DialogHeader>
                    <DialogTitle>Log Timesheet</DialogTitle>
                    <DialogDescription>
                        {status === 'NOT_CLOCKED_IN'
                            ? "Enter the password to clock in."
                            : "Click the button below to clock out."}
                    </DialogDescription>
                </DialogHeader>
                <Form {...form}>
                    <form onSubmit={form.handleSubmit(onSubmit)}>
                        {status === 'NOT_CLOCKED_IN' && (
                            <div className="grid gap-4 py-4">
                                <FormField
                                    control={form.control}
                                    name='password'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Password</FormLabel>
                                            <FormControl>
                                                <div className="relative">
                                                    <Input
                                                        {...field}
                                                        disabled={isPending}
                                                        type={showPassword ? "text" : "password"}
                                                        placeholder='Enter password'
                                                    />
                                                    <Button
                                                        type="button"
                                                        variant="link"
                                                        size="sm"
                                                        className="absolute inset-y-0 right-0 flex items-center pr-3"
                                                        onClick={() => setShowPassword(!showPassword)}
                                                    >
                                                        {showPassword ? <FiEyeOff /> : <FiEye />}
                                                    </Button>
                                                </div>
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                        )}
                        <FormError message={error} />
                        {/* <FormSucess message={success} /> */}
                        <Button
                            variant={"auth"}
                            disabled={isPending || status === 'CLOCKED_OUT'}
                            type='submit'
                            className='w-full mt-2'
                        >
                            {getButtonText(status)}
                        </Button>
                    </form>
                </Form>
            </DialogContent>
        </Dialog>
    );
}