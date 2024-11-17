"use client"

import React, { useState, useEffect } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'

import { EditUserDetailsSchema } from '@/schemas/register-index'
import { editUserDetails } from '@/actions/superadmin/edit-user-details'
import { useUserDetails } from '@/hooks/use-user-details'

import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { FormError } from "@/components/form-error"
import { FormSucess } from "@/components/form-sucess"
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { Gender } from '@prisma/client'

interface Props {
    userId: string
}

export const EditUserDetailsDialog = ({ userId }: Props) => {
    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");
    const [isPending, setIsPending] = useState(false);
    const [open, setOpen] = useState(false);

    const { user } = useUserDetails(userId);

    const form = useForm<z.infer<typeof EditUserDetailsSchema>>({
        resolver: zodResolver(EditUserDetailsSchema),
        defaultValues: {
            userId: userId,
            email: "",
            firstName: "",
            middleName: "",
            lastName: "",
            birthDate: "",
        }
    })

    useEffect(() => {
        if (user) {
            const formData = {
                userId: user.id,
                email: user.email ?? undefined,
                firstName: user.firstName ?? undefined,
                middleName: user.middleName ?? undefined,
                lastName: user.lastName ?? undefined,
                gender: (user.gender ?? undefined),
                birthDate: user.dateOfBirth ? user.dateOfBirth.toISOString().split('T')[0] : undefined
            };
            form.reset(formData);
        }
    }, [user, form]);

    const onSubmit = async (values: z.infer<typeof EditUserDetailsSchema>) => {
        setError("")
        setSuccess("")
        setIsPending(true)

        const formattedValues = {
            ...values,
            birthDate: new Date(values.birthDate).toISOString(),
        }

        try {
            const data = await editUserDetails(formattedValues)
            if (data.error) {
                setError(data.error)
            }
            if (data.success) {
                setSuccess(data.success)
                setOpen(false)
                setTimeout(() => {
                    window.location.reload()
                }, 300)
            }
        } catch (error) {
            setError("An error occurred!")
        } finally {
            setIsPending(false)
        }
    };

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="auth" size={"lg"} className="">Edit User Details</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>Edit User Details</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name="firstName"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>First Name</FormLabel>
                                            <FormControl>
                                                <Input {...field} disabled={isPending} placeholder="John" />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="middleName"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Middle Name</FormLabel>
                                            <FormControl>
                                                <Input {...field} disabled={isPending} placeholder="Doe" />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="lastName"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Last Name</FormLabel>
                                            <FormControl>
                                                <Input {...field} disabled={isPending} placeholder="Smith" />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="email"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Email</FormLabel>
                                            <FormControl>
                                                <Input {...field} disabled={isPending} type="email" placeholder="john.doe@example.com" />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="gender"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Gender</FormLabel>
                                            <Select disabled={isPending} onValueChange={field.onChange} defaultValue={field.value}>
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Select Gender" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value={Gender.MALE}>Male</SelectItem>
                                                    <SelectItem value={Gender.FEMALE}>Female</SelectItem>
                                                    <SelectItem value={Gender.OTHER}>Other</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="birthDate"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Birth Date</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    type="date"
                                                    onChange={(e) => field.onChange(e.target.value)}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                                    Edit User Details
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}