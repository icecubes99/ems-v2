"use client"

import React from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { AssignedDesignationSchema } from '@/schemas/superadminIndex';
import { createAssignedUser } from '@/actions/superadmin/createAssignedUser';
import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";

import { Input } from "@/components/ui/input";
import { Button, ButtonProps } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { Card, CardContent, CardDescription, CardFooter, CardHeader } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { EmployeeType, Status } from '@prisma/client';
import SelectUser from '../../_components/SelectUser';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import useDesignation from '@/hooks/use-designation';
import SelectNonAssignedUsers from './select-user-assigned-user';

interface CreateAssignedUserFormProps {
    designationId: string;
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

const CreateAssignedUserForm: React.FC<CreateAssignedUserFormProps> = ({ designationId, variant }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof AssignedDesignationSchema>>({
        resolver: zodResolver(AssignedDesignationSchema),
        defaultValues: {
            userId: "",
            employeeType: EmployeeType.REGULAR,
            status: Status.ACTIVE,
            designationId: designationId
        }
    });

    const designationDetails = useDesignation(designationId);
    const designationName = designationDetails?.designationName;

    const [open, setOpen] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const onSubmit = (values: z.infer<typeof AssignedDesignationSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            createAssignedUser(values)
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
        })
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger>
                <Button className='w-full' variant={variant}>Assign User</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className=''>
                    <CardHeader>
                        Assign User for {designationName}
                        <CardDescription>
                            Input the User Info Below
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">

                                <div className='space-y-4'>

                                    <div>
                                        {/* USER ASSIGNED */}
                                        <FormField
                                            control={form.control}
                                            name='userId'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>User To be Assigned</FormLabel>
                                                    <SelectNonAssignedUsers onUserChange={field.onChange} />
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>

                                    <div>
                                        {/* STATUS */}
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

                                    <div>
                                        {/* EMPLOYEE TYPE */}
                                        <FormField
                                            control={form.control}
                                            name='employeeType'
                                            render={({ field }) => (
                                                <FormItem>
                                                    <FormLabel>Employee Type</FormLabel>
                                                    <Select
                                                        disabled={isPending}
                                                        onValueChange={field.onChange}
                                                        defaultValue={field.value}
                                                    >
                                                        <FormControl>
                                                            <SelectTrigger>
                                                                <SelectValue placeholder="Select the Employee Type" />
                                                            </SelectTrigger>
                                                        </FormControl>
                                                        <SelectContent>
                                                            <SelectItem value={EmployeeType.REGULAR}>Regular</SelectItem>
                                                            <SelectItem value={EmployeeType.CONTRACTUAL}>Contractual</SelectItem>
                                                            <SelectItem value={EmployeeType.PROBATIONARY}>Probationary</SelectItem>
                                                        </SelectContent>
                                                    </Select>
                                                    <FormMessage />
                                                </FormItem>
                                            )}
                                        />
                                    </div>

                                </div>
                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant={variant} disabled={isPending} type='submit' className='w-full'>
                                    Assign User
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}
export default CreateAssignedUserForm;