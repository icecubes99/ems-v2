"use client"
import React, { useEffect, useRef, useState, useTransition } from 'react'
import * as z from 'zod';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

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
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { PayrollFirstsStep } from '@/schemas/payroll-index';
import { generatePayrollManual } from '@/actions/superadmin/generate-payroll-manual';

export const GeneratePayrollManualDialog = () => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof PayrollFirstsStep>>({
        resolver: zodResolver(PayrollFirstsStep),
        defaultValues: {
            payPeriodStart: "",
            payPeriodEnd: "",
        }
    });

    const onSubmit = (values: z.infer<typeof PayrollFirstsStep>) => {
        setError("");
        setSuccess("");

        const formattedValues = {
            payPeriodStart: new Date(values.payPeriodStart).toISOString(),
            payPeriodEnd: new Date(values.payPeriodEnd).toISOString(),
        }

        startTransition(() => {
            generatePayrollManual(formattedValues)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }

                    if (data.success) {
                        setSuccess(data.success);
                        setTimeout(() => {
                            window.location.reload();
                        }, 300)
                    }
                })
                .catch(() => setError("An error occurred!"));
        });
    };

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"auth"}>
                    Generate Payroll Manually
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-[500px]'>
                    <CardHeader>
                        <CardTitle>Add Payroll Manually</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>

                                <FormField
                                    control={form.control}
                                    name="payPeriodStart"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Payroll Period <span className='text-red-500 font-bold'>Start</span> Date</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    type="date"
                                                    onChange={(e) => field.onChange(e.target.value)}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="payPeriodEnd"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Payroll Period <span className='text-red-500 font-bold'>End</span> Date</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    type="date"
                                                    onChange={(e) => field.onChange(e.target.value)}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button disabled={isPending} variant={"superadmin"} type='submit' className='w-full'>
                                    Generate Payroll
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}