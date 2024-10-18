"use client"

import React, { useEffect, useRef } from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { DesignationSchema } from '@/schemas/superadminIndex';
import { createDesignation } from '@/actions/superadmin/createDesignation';

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
import { Card, CardContent, CardDescription, CardFooter, CardHeader } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Status } from '@prisma/client';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { useDepartment } from '@/hooks/use-department';
import SelectUserDesignationHead from './select-user-designation-head';


interface CreateDesignationFormWithDeptProps {
    departmentId: string;
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

const CreateSpecificDesignationForm: React.FC<CreateDesignationFormWithDeptProps> = ({ variant, departmentId }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const inputRef = useRef<HTMLInputElement>(null)
    const [formattedSalary, setFormattedSalary] = useState("")
    const formatNumber = (num: number) => {
        return "₱" + num.toLocaleString('en-US')
    }

    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof DesignationSchema>>({
        resolver: zodResolver(DesignationSchema),
        defaultValues: {
            designationName: "",
            designationDescription: "",
            status: Status.ACTIVE,
            departmentId: departmentId, // Use departmentId prop as default value
            designationHeadUserId: "",
            designationSalary: 0,
        }
    });
    const departmentDetails = useDepartment(departmentId);
    const departmentName = departmentDetails.departmentName;

    const [open, setOpen] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const onSubmit = (values: z.infer<typeof DesignationSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            createDesignation(values)
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
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger>
                <Button className='w-full' variant={variant}>Create Designation</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        Create Designation for {departmentName}
                        <CardDescription>
                            Input the details of the new designation
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>

                                <div className='space-y-4'>

                                    {/* DESIGNATION NAME */}
                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='designationName'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Designation Name</FormLabel>
                                                    <FormControl>
                                                        <Input
                                                            {...field}
                                                            disabled={isPending}
                                                            placeholder='Electrical Engineering'
                                                        />
                                                    </FormControl>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>

                                    {/* DESIGNATION DESCRIPTION */}
                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='designationDescription'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Designation Description</FormLabel>
                                                    <FormControl>
                                                        <Input
                                                            {...field}
                                                            disabled={isPending}
                                                            placeholder='Team Electric'
                                                        />
                                                    </FormControl>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>

                                    {/* DESIGNATION STATUS */}
                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='status'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Status</FormLabel>
                                                    <Select
                                                        disabled={isPending}
                                                        onValueChange={field.onChange}
                                                        defaultValue={field.value}
                                                    >
                                                        <FormControl>
                                                            <SelectTrigger>
                                                                <SelectValue placeholder="Pick the status" />
                                                            </SelectTrigger>
                                                        </FormControl>
                                                        <SelectContent>
                                                            <SelectItem value={Status.ACTIVE}>Active</SelectItem>
                                                            <SelectItem value={Status.INACTIVE}>Inactive</SelectItem>
                                                        </SelectContent>
                                                    </Select>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>

                                    {/* DESIGNATION HEAD */}
                                    <div>
                                        <FormField
                                            control={form.control}
                                            name='designationHeadUserId'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Designation Head</FormLabel>
                                                    <SelectUserDesignationHead onUserChange={field.onChange} />
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>


                                    {/* Basic Salary */}
                                    <FormField
                                        control={form.control}
                                        name="designationSalary"
                                        render={({ field }) => (
                                            <FormItem>
                                                <FormLabel>Basic Salary</FormLabel>
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

                                    {/* DEPARTMENT PARENT */}
                                    <div className='hidden'>
                                        <FormField
                                            control={form.control}
                                            name='departmentId'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Department</FormLabel>
                                                    <Input
                                                        {...field}
                                                        disabled={true} // Make this field read-only
                                                        value={departmentId} // Set the value to the departmentId prop
                                                    />
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>
                                </div>
                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant={variant} disabled={isPending} type='submit' className='w-full'>
                                    Create Designation
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>


            </DialogContent>
        </Dialog>
    )

}
export default CreateSpecificDesignationForm;
