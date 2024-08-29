"use client"

import React from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { DepartmentSchema } from '@/schemas/superadminIndex';
import { createDepartment } from '@/actions/superadmin/createDepartment';

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
import SelectUser from '../../_components/SelectUser';

const CreateDepartmentForm = () => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof DepartmentSchema>>({
        resolver: zodResolver(DepartmentSchema),
        defaultValues: {
            departmentName: "",
            departmentDescription: "",
            departmentHeadUserId: "",
            status: Status.ACTIVE,
        }
    });

    const onSubmit = (values: z.infer<typeof DepartmentSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            createDepartment(values).then((data) => {
                setError(data.error);
                setSuccess(data.success);
            });
        });
    }

    return (
        <Card className='bg-red-50'>
            <CardHeader>
                Create a New Department
                <CardDescription>
                    Input the information for this new Department below
                </CardDescription>
            </CardHeader>
            <CardContent>
                <Form {...form}>
                    <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>

                        <div className='space-y-4'>

                            {/* DEPARTMENT NAME */}
                            <div>
                                <FormField
                                    control={form.control}
                                    name='departmentName'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Department Name</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder='Engineering'
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>

                            {/* DEPARTMENT DESCRIPTION */}
                            <div>
                                <FormField
                                    control={form.control}
                                    name='departmentDescription'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Department Description</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder='Handles all of the Engineering Teams'
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>

                            {/* DEPARTMENT STATUS */}
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
                                                        <SelectValue placeholder="Pick the status of this Department" />
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

                            {/* DEPARTMENT HEAD */}
                            <div>
                                <FormField
                                    control={form.control}
                                    name='departmentHeadUserId'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Department Head</FormLabel>
                                            <SelectUser onUserChange={field.onChange} />
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                        </div>
                        <FormError message={error} />
                        <FormSucess message={success} />
                        <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                            Create Department
                        </Button>
                    </form>
                </Form>
            </CardContent>
        </Card>
    )

}

export default CreateDepartmentForm;