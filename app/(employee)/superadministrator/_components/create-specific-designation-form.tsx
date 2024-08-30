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
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import useDepartment from '@/hooks/use-department';


interface CreateDesignationFormWithDeptProps {
    departmentId: string;
}

const CreateSpecificDesignationForm: React.FC<CreateDesignationFormWithDeptProps> = ({ departmentId }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof DesignationSchema>>({
        resolver: zodResolver(DesignationSchema),
        defaultValues: {
            designationName: "",
            designationDescription: "",
            status: Status.ACTIVE,
            departmentId: departmentId, // Use departmentId prop as default value
            designationHeadUserId: "",
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

        console.log("Form Values:", values);
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

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger>
                <Button className='w-full' variant='superadmin'>Create Designation</Button>
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
                                <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
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
