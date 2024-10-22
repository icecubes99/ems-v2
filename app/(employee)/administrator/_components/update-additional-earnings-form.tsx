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
import { Dialog, DialogContent } from '@/components/ui/dialog';
import { Textarea } from '@/components/ui/textarea';

import SelectUser from '../../_components/SelectUser';
import { useAdditionalEarning } from '@/hooks/use-additional-earnings';
import { updateAdditionalEarningsToUser } from '@/actions/superadmin/update-additional-earnings-to-user';
import { AdditionalEarningsSoloSchema } from '@/schemas/payroll-index';

interface AdditionalEarningsFormProps {
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
    additionalEarningsId: string;
    isOpen: boolean;
    onOpenChange: (isOpen: boolean) => void;
}

const UpdateAdditionalEarningsForm: React.FC<AdditionalEarningsFormProps> = ({ variant, additionalEarningsId, isOpen, onOpenChange }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const { additionalEarning } = useAdditionalEarning(additionalEarningsId)

    const [formattedSalary, setFormattedSalary] = useState("")
    const inputRef = useRef<HTMLInputElement>(null)

    const formatNumber = (num: number) => {
        return "₱" + num.toLocaleString('en-US')
    }

    const handleOpenChange = (newOpen: boolean) => {
        onOpenChange(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const form = useForm<z.infer<typeof AdditionalEarningsSoloSchema>>({
        resolver: zodResolver(AdditionalEarningsSoloSchema),
        defaultValues: {
            userId: "",
            earningType: "",
            amount: 0,
            description: "",
        },
    })

    useEffect(() => {
        if (additionalEarning) {
            const formattedAdditionalEarning = {
                ...additionalEarning,
                amount: additionalEarning.amount // Keep amount as number for form reset
            };
            form.reset(formattedAdditionalEarning);
            setFormattedSalary(formatNumber(additionalEarning.amount)); // Format amount for display
        }
    }, [additionalEarning, form]);

    const onSubmit = (values: z.infer<typeof AdditionalEarningsSoloSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            updateAdditionalEarningsToUser(values, additionalEarningsId)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }

                    if (data.success) {
                        setSuccess(data.success);
                        handleOpenChange(false);
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
                            Update Existing Additional Earning
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
                                                    <FormLabel>Employee</FormLabel>
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
                                            name='earningType'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Type</FormLabel>
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
                                                            <SelectItem value={"Reimbursement"}>Reimbursement</SelectItem>
                                                            <SelectItem value={"Bonus"}>Bonus</SelectItem>
                                                            <SelectItem value={"Allowance"}>Allowance</SelectItem>
                                                            <SelectItem value={"Others"}>Others</SelectItem>
                                                        </SelectContent>
                                                    </Select>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />



                                        {/* AMOUNT ADDED */}
                                        <FormField
                                            control={form.control}
                                            name="amount"
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Amount Added</FormLabel>
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
                                    Add Amount
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}

export default UpdateAdditionalEarningsForm;