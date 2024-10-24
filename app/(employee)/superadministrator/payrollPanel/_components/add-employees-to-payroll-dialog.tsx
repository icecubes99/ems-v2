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
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { addEmployeeToPayrollCalculated } from '@/actions/superadmin/generate-payroll-manual';
import { AddEmployeeToPayrollCalculatedSchema } from '@/schemas/payroll-index';
import SelectUser from '@/app/(employee)/_components/SelectUser';
import { UserPlus } from 'lucide-react';
import { MultiSelectUsers } from '@/components/ui/multi-select-components';

interface Props {
    payrollId: string;
}
export const AddEmployeesToPayrollDialog = ({ payrollId }: Props) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof AddEmployeeToPayrollCalculatedSchema>>({
        resolver: zodResolver(AddEmployeeToPayrollCalculatedSchema),
        defaultValues: {
            userIds: [],
        }
    });

    const onSubmit = (values: z.infer<typeof AddEmployeeToPayrollCalculatedSchema>) => {
        setError("");
        setSuccess("");


        startTransition(() => {
            addEmployeeToPayrollCalculated(payrollId, values)
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
                <Button className='w-16 h-16 mr-5 rounded-full' variant={"default"}>
                    <UserPlus className='h-7 w-7' />
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-[500px]'>
                    <CardHeader>
                        <CardTitle>Add Employee To Payroll</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>

                                <FormField
                                    control={form.control}
                                    name="userIds"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Pick Employee</FormLabel>
                                            <FormControl>
                                                <MultiSelectUsers
                                                    onChange={(values) => field.onChange(values)}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button disabled={isPending} variant={"superadmin"} type='submit' className='w-full'>
                                    Add Employee
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}