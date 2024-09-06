"use client"

import React from 'react'
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
import SelectDepartments from './SelectDepartments';
import SelectUser from '../../_components/SelectUser';

interface CreateDesignationFormProps {
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

const CreateDesignationForm = ({ variant }: CreateDesignationFormProps) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof DesignationSchema>>({
        resolver: zodResolver(DesignationSchema),
        defaultValues: {
            designationName: "",
            designationDescription: "",
            status: Status.ACTIVE,
            departmentId: "",
            designationHeadUserId: "",
        }
    });

    const onSubmit = (values: z.infer<typeof DesignationSchema>) => {
        setError("");
        setSuccess("");

        console.log("Form Values:", values);
        startTransition(() => {
            createDesignation(values).then((data) => {
                setError(data.error);
                setSuccess(data.success);
            });
        });
    }

    return (
        <Card>
            <CardHeader>
                Create Designation
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

                            {/* DESIGNATION HEAD */}
                            <div>
                                <FormField
                                    control={form.control}
                                    name='designationHeadUserId'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Designation Head</FormLabel>
                                            <SelectUser onUserChange={field.onChange} />
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>

                            {/* DEPARTMENT PARENT */}
                            <div>
                                <FormField
                                    control={form.control}
                                    name='departmentId'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Designation Head</FormLabel>
                                            <SelectDepartments onUserChange={field.onChange} />
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
    )

}
export default CreateDesignationForm;