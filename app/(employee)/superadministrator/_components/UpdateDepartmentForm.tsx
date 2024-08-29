"use client"

import React, { useEffect } from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { DepartmentSchema } from '@/schemas/superadminIndex';

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
import useDepartment from '@/hooks/use-department';
import { updateDepartment } from '@/actions/superadmin/updateDepartment';

interface UpdateDepartmentFormProps {
    departmentId: string;
}

const UpdateDepartmentForm: React.FC<UpdateDepartmentFormProps> = ({ departmentId }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const [isPending, startTransition] = useTransition();

    const { department, loading } = useDepartment(departmentId);




    const form = useForm<z.infer<typeof DepartmentSchema>>({
        resolver: zodResolver(DepartmentSchema),
        defaultValues: {
            departmentName: "",
            departmentDescription: "",
            departmentHeadUserId: "",
            status: Status.ACTIVE,
        }
    });

    useEffect(() => {
        if (department) {
            form.reset(department);
        }
    }, [department, form]);

    const onSubmit = (values: z.infer<typeof DepartmentSchema>) => {
        startTransition(() => {
            updateDepartment(departmentId, values)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }

                    if (data.success) {

                        setSuccess(data.success);
                    }
                })
                .catch(() => setError("An error what!"));
        });
    };
    if (loading) {
        return <p>Loading...</p>;
    }
    return (
        <Card className='bg-red-50'>
            <CardHeader>
                Update a  Department for Kupler Industries
                <CardDescription>
                    Input the information for this Department below
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
                                                value={field.value}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Pick the status of this Department" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent >
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
                                            <SelectUser value={field.value} onUserChange={field.onChange} />
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                        </div>
                        <FormError message={error} />
                        <FormSucess message={success} />
                        <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                            Update Department
                        </Button>
                    </form>
                </Form>
            </CardContent>
        </Card>
    )

}

export default UpdateDepartmentForm;