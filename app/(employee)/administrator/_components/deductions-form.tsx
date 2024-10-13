"use client"

import React, { useEffect, useRef, useState, useTransition } from 'react'
import * as z from 'zod';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { DeductionsSchema } from '@/schemas/payroll-index';
import { addDeductionsToUser } from '@/actions/superadmin/addDeductionsToUser';

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
import { Status } from '@prisma/client';

import SelectUser from '../../_components/SelectUser';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { Textarea } from '@/components/ui/textarea';
import { Skeleton } from '@/components/ui/skeleton';

interface DeductionsFormProps {
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

const AddDeductionsForm: React.FC<DeductionsFormProps> = ({ variant }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const [open, setOpen] = useState(false);
    const [isMounted, setIsMounted] = useState(false);

    const [formattedSalary, setFormattedSalary] = useState("")
    const inputRef = useRef<HTMLInputElement>(null)

    const formatNumber = (num: number) => {
        return "₱" + num.toLocaleString('en-US')
    }

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const form = useForm<z.infer<typeof DeductionsSchema>>({
        resolver: zodResolver(DeductionsSchema),
        defaultValues: {
            userId: "",
            deductionType: "",
            amount: 0,
            description: "",
        },
    })

    const onSubmit = (values: z.infer<typeof DeductionsSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            addDeductionsToUser(values)
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
                .catch(() => setError("An error occurred!"));
        });
    }

    useEffect(() => {
        setIsMounted(true);
    }, []);

    useEffect(() => {
        const handleClick = () => {
            if (inputRef.current) {
                const input = inputRef.current
                setTimeout(() => {
                    input.setSelectionRange(input.value.length, input.value.length)
                }, 0)
            }
        }

        const input = inputRef.current
        input?.addEventListener('click', handleClick)

        return () => {
            input?.removeEventListener('click', handleClick)
        }
    }, [])

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            {isMounted ? (
                <DialogTrigger>
                    <Button size={"lg"} className='w-full' variant={variant}>Add Deductions</Button>
                </DialogTrigger>
            ) : (
                <Button size={"lg"} className='w-full' variant={variant}>Add Deductions</Button>
            )}
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>
                            Add Deductions to An Employee
                        </CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <div className='space-y-4'>

                                    {/* EMPLOYEE NAME */}
                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='userId'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Employee to be Deducted</FormLabel>
                                                    <SelectUser onUserChange={field.onChange} />
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>


                                    {/* TYPE */}
                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='deductionType'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Deduction Type</FormLabel>
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
                                                            <SelectItem value={"Disbursement"}>Disbursement</SelectItem>
                                                            <SelectItem value={"Salary Advance"}>Salary Advance</SelectItem>
                                                            <SelectItem value={"Loan"}>Loan</SelectItem>
                                                            <SelectItem value={"Others"}>Others</SelectItem>
                                                        </SelectContent>
                                                    </Select>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />



                                        {/* AMOUNT DEDUCTED */}
                                        <FormField
                                            control={form.control}
                                            name="amount"
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Amount Deducted</FormLabel>
                                                    <FormControl>
                                                        <Input
                                                            {...field}
                                                            ref={inputRef}
                                                            disabled={isPending}
                                                            type="text"
                                                            placeholder="₱0"
                                                            value={formattedSalary}
                                                            onChange={(e) => {
                                                                const value = e.target.value.replace(/[^0-9]/g, '')
                                                                const numberValue = parseInt(value, 10)
                                                                const formatted = formatNumber(numberValue || 0)
                                                                setFormattedSalary(formatted)
                                                                field.onChange(numberValue || 0)

                                                                // Move cursor to end
                                                                setTimeout(() => {
                                                                    e.target.setSelectionRange(formatted.length, formatted.length)
                                                                }, 0)
                                                            }}
                                                            onFocus={(e) => {
                                                                e.target.setSelectionRange(e.target.value.length, e.target.value.length)
                                                            }}
                                                        />
                                                    </FormControl>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />

                                        <FormField
                                            control={form.control}
                                            name='description'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Description</FormLabel>
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
                                <Button variant={variant} disabled={isPending} type='submit' className='w-full'>
                                    Deduct Amount
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}

export default AddDeductionsForm;