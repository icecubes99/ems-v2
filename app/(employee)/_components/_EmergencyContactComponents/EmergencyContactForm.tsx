"use client"
import React from 'react'
import * as z from 'zod';
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";


import { EmergencyContactSchema } from '@/schemas';

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
import { addEmergencyContact } from '@/actions/addEmergencyContact';
import { Card, CardContent, CardDescription, CardFooter, CardHeader } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

interface EmergencyContactFormProps {
    userId: string;
}


const EmergencyContactForm = ({ userId }: EmergencyContactFormProps) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const [isPending, startTransition] = useTransition();

    const form = useForm<z.infer<typeof EmergencyContactSchema>>({
        resolver: zodResolver(EmergencyContactSchema),
        defaultValues: {
            firstName: "",
            middleName: "",
            lastName: "",
            relationship: "",
            contactNumber: "",
            emailAddress: "",
        }
    });

    const onSubmit = (values: z.infer<typeof EmergencyContactSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            addEmergencyContact(userId, values).then((data) => {
                setError(data.error);
                setSuccess(data.success);
            });
        });
    }

    return (
        <Card>

            <CardHeader>
                <p>Add your Emergency Contact</p>
                <CardDescription>
                    <p>Type the neccessary information in the form below</p>
                </CardDescription>
            </CardHeader>
            <CardContent>
                <Form {...form}>
                    <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                        <div className='space-y-4'>

                            <div className='flex flex-row gap-4'>
                                {/* FIRST NAME */}
                                <FormField
                                    control={form.control}
                                    name='firstName'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>First Name</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder='Shan'
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                {/* MIDDLE NAME */}
                                <FormField
                                    control={form.control}
                                    name='middleName'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Middle Name</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder='Nuel'
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>

                            <div className='flex flex-row gap-4'>
                                {/* LAST NAME */}
                                <FormField
                                    control={form.control}
                                    name='lastName'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Last Name</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder='Tranquilan'
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />


                                {/* RELATIONSHIP */}
                                <FormField
                                    control={form.control}
                                    name='relationship'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Relationship</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={field.onChange}
                                                defaultValue={field.value}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Who are you to this contact?" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value='Mother'>Mother</SelectItem>
                                                    <SelectItem value='Father'>Father</SelectItem>
                                                    <SelectItem value='Son'>Son</SelectItem>
                                                    <SelectItem value='Daughter'>Daughter</SelectItem>
                                                    <SelectItem value='Sibling'>Sibling</SelectItem>
                                                    <SelectItem value='Cousin'>Cousin</SelectItem>
                                                    <SelectItem value='Partner'>Partner</SelectItem>
                                                    <SelectItem value='Friend'>Friend</SelectItem>
                                                    <SelectItem value='Relative'>Relative</SelectItem>
                                                    <SelectItem value='Other'>Other</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>

                            <div className='flex flex-row gap-4'>
                                {/* CONTACT NUMBER */}
                                <FormField
                                    control={form.control}
                                    name='contactNumber'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Contact Number</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder='09123456789'
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                {/* EMAIL ADDRESS */}
                                <FormField
                                    control={form.control}
                                    name='emailAddress'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Email Address</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder='snstranquilan@gmail.com'
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
                        <Button variant={"auth"} disabled={isPending} type='submit' className='w-full'>
                            Add Emergency Contact
                        </Button>
                    </form>
                </Form>
            </CardContent>

        </Card>
    )
}

export default EmergencyContactForm;