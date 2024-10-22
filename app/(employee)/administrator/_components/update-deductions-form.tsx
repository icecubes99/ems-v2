"use client"

import React, { useEffect, useRef, useState, useTransition } from 'react'
import * as z from 'zod';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { DeductionsSoloSchema } from '@/schemas/payroll-index';
import { updateDeductionsToUser } from '@/actions/superadmin/update-deductions-to-user';

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
import { Dialog, DialogContent } from '@/components/ui/dialog';
import { Textarea } from '@/components/ui/textarea';
import { useDeduction } from '@/hooks/use-deductions';
import { Skeleton } from '@/components/ui/skeleton';

import SelectUser from '../../_components/SelectUser';

interface DeductionsFormProps {
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
    deductionId: string;
    isOpen: boolean;
    onOpenChange: (isOpen: boolean) => void;
}

const UpdateDeductionsForm: React.FC<DeductionsFormProps> = ({ variant, deductionId, isOpen, onOpenChange }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const { deduction, isLoading } = useDeduction(deductionId);

    const [formattedSalary, setFormattedSalary] = useState("")
    const inputRef = useRef<HTMLInputElement>(null)

    const formatNumber = (num: number) => {
        return "₱" + num.toLocaleString('en-US')
    }

    const handleOpenChange = (newOpen: boolean) => {
        onOpenChange(newOpen);
    }

    const form = useForm<z.infer<typeof DeductionsSoloSchema>>({
        resolver: zodResolver(DeductionsSoloSchema),
        defaultValues: {
            userId: "",
            deductionType: "",
            amount: 0,
            description: "",
        },
    })

    useEffect(() => {
        if (deduction) {
            const formattedDeduction = {
                ...deduction,
                amount: deduction.amount
            };
            form.reset(formattedDeduction);
            setFormattedSalary(formatNumber(deduction.amount));
        }
    }, [deduction, form]);

    const onSubmit = (values: z.infer<typeof DeductionsSoloSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            updateDeductionsToUser(values, deductionId)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }

                    if (data.success) {
                        setSuccess(data.success);
                        handleOpenChange(false);
                        setTimeout(() => {
                            window.location.reload();
                        }, 300);
                    }
                })
                .catch(() => setError("An error occurred!"));
        });
    }

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
        <Dialog open={isOpen} onOpenChange={handleOpenChange}>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>
                            Update Existing Deduction
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
                                                    <SelectUser value={field.value} onUserChange={field.onChange} />
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
                                                        value={field.value}
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

export default UpdateDeductionsForm;