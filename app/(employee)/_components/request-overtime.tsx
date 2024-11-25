'use client'

import React, { useState, useTransition, useEffect } from 'react';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from 'zod';
import { Clock8 } from 'lucide-react';

import { Button } from "@/components/ui/button";
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from "@/components/ui/dialog";
import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";

import { OvertimeSchema } from '@/schemas/attendance-index';
import { requestOvertime, clockOutOvertime } from '@/actions/requestOvertime';

import { useOvertimeStatus, OvertimeStatus } from '@/hooks/use-overtime-status';
import { OvertimeType } from '@prisma/client';

export default function OvertimeClock() {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();
    const [open, setOpen] = useState(false);
    const { status, isLoading, refreshStatus } = useOvertimeStatus();
    const [isButtonDisabled, setIsButtonDisabled] = useState(true);

    const form = useForm<z.infer<typeof OvertimeSchema>>({
        resolver: zodResolver(OvertimeSchema),
        defaultValues: {
            reason: "",
            overtimeType: OvertimeType.REGULAR,
            timeOut: "18:01"
        }
    });

    useEffect(() => {
        const checkTime = () => {
            const now = new Date();
            const currentMinutes = now.getHours() * 60 + now.getMinutes();
            const minTime = 17 * 60 + 55; // 5:55 PM in minutes
            const maxTime = 22 * 60; // 10:00 PM in minutes
            setIsButtonDisabled(currentMinutes < minTime || currentMinutes > maxTime);
        };

        checkTime();
        const interval = setInterval(checkTime, 60000); // Check every minute

        return () => clearInterval(interval);
    }, []);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            form.reset();
            setError("");
            setSuccess("");
        }
    };

    const onSubmit = (values: z.infer<typeof OvertimeSchema>) => {
        setError("");
        setSuccess("");

        console.log("Submitted values:", values);

        startTransition(() => {
            requestOvertime(values)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                        if (data.details) {
                            console.error("Validation errors:", data.details);
                        }
                    }
                    if (data.success) {
                        setSuccess(data.success);
                        setOpen(false);
                        refreshStatus();
                    }
                })
                .catch((err) => {
                    console.error("Error submitting overtime:", err);
                    setError("An unexpected error occurred");
                });
        });
    };

    const handleClockOut = () => {
        startTransition(() => {
            clockOutOvertime()
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }
                    if (data.success) {
                        setSuccess(data.success);
                        refreshStatus();
                    }
                })
                .catch((err) => {
                    console.error("Error clocking out from overtime:", err);
                    setError("Error clocking out from overtime");
                });
        });
    };

    const getButtonText = (status: OvertimeStatus) => {
        switch (status) {
            case 'NOT_RECORDED':
                return "Start Overtime";
            case 'IN_PROGRESS':
                return "End Overtime";
            case 'COMPLETED':
                return "Overtime Completed";
            default:
                return "Overtime";
        }
    };

    return (
        <Dialog open={open} onOpenChange={handleOpenChange}>
            <DialogTrigger asChild>
                <Button
                    variant="outline"
                    size="lg"
                    className="h-auto w-full py-4 flex flex-col items-center justify-center"
                    disabled={isLoading || status === 'COMPLETED' || isButtonDisabled}
                    onClick={() => {
                        if (status === 'IN_PROGRESS') {
                            handleClockOut();
                        } else {
                            setOpen(true);
                        }
                    }}
                >
                    <Clock8 className="w-6 h-6 mb-2" />
                    {isLoading ? "Loading..." : getButtonText(status)}
                </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px]">
                <DialogHeader>
                    <DialogTitle>Request Overtime</DialogTitle>
                    <DialogDescription>
                        Fill in the details to request overtime and clock in.
                    </DialogDescription>
                </DialogHeader>
                <Form {...form}>
                    <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
                        {status === "NOT_RECORDED" && (
                            <div>
                                <FormField
                                    control={form.control}
                                    name="overtimeType"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Overtime Type</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={field.onChange}
                                                defaultValue={field.value}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Select overtime type" />
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
                                <FormField
                                    control={form.control}
                                    name="reason"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Reason</FormLabel>
                                            <FormControl>
                                                <Textarea
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder="Enter reason for overtime"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                {/* <FormField
                                    control={form.control}
                                    name="timeOut"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Expected End Time</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    type="time"
                                                    disabled={isPending}
                                                    min="18:01"
                                                    max="21:00"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                /> */}
                            </div>)}
                        <FormError message={error} />
                        <FormSucess message={success} />
                        <Button
                            variant="default"
                            disabled={isPending || status === "COMPLETED"}
                            type="submit"
                            className="w-full"
                        >
                            {getButtonText(status)}
                        </Button>
                    </form>
                </Form>
            </DialogContent>
        </Dialog>
    );
}