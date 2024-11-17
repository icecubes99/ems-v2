"use client"

import React, { useState } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'

import { newPasswordOtherProfile, newPasswordProfile } from '@/actions/new-password'
import { verifyUserPassword } from '@/data/fetch-passwords'
import { NewPasswordSchema } from '@/schemas'

import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { FormError } from "@/components/form-error"
import { FormSucess } from "@/components/form-sucess"
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { KeyRound } from 'lucide-react'

const ChangePasswordSchema = z.object({
    oldPassword: z.string().min(1, "Old password is required"),
    password: z.string().min(6, "Minimum 6 characters required"),
    confirmPassword: z.string()
}).refine((data) => data.password === data.confirmPassword, {
    message: "Passwords don't match",
    path: ["confirmPassword"],
});

const ChangeOtherPasswordSchema = z.object({
    password: z.string().min(6, "Minimum 6 characters required"),
    confirmPassword: z.string()
}).refine((data) => data.password === data.confirmPassword, {
    message: "Passwords don't match",
    path: ["confirmPassword"],
});

export default function ChangePasswordForm() {
    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");
    const [isPending, setIsPending] = useState(false);
    const [open, setOpen] = useState(false);

    const form = useForm<z.infer<typeof ChangePasswordSchema>>({
        resolver: zodResolver(ChangePasswordSchema),
        defaultValues: {
            oldPassword: "",
            password: "",
            confirmPassword: ""
        }
    });

    const onSubmit = async (values: z.infer<typeof ChangePasswordSchema>) => {
        setError("");
        setSuccess("");
        setIsPending(true);

        try {
            // First verify old password
            const verifyResult = await verifyUserPassword(values.oldPassword);

            if (verifyResult.error) {
                setError(verifyResult.error);
                return;
            }

            // If old password is correct, proceed with password update
            const result = await newPasswordProfile({
                password: values.password
            });

            if (result.error) {
                setError(result.error);
            }

            if (result.success) {
                setSuccess(result.success);
                form.reset();
                setOpen(false);
                setTimeout(() => {
                    setOpen(false)
                    window.location.reload()
                }, 1000)
            }
        } catch (error) {
            setError("Something went wrong!");
        } finally {
            setIsPending(false);
        }
    };

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="outline">
                    <KeyRound className="h-4 w-4 mr-2" />
                    Change Password
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 bg-transparent border-none">
                <Card>
                    <CardHeader>
                        <CardTitle>Change Password</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                                <FormField
                                    control={form.control}
                                    name="oldPassword"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Old Password</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder="••••••••"
                                                    type="password"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="password"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>New Password</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder="••••••••"
                                                    type="password"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="confirmPassword"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Confirm New Password</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder="••••••••"
                                                    type="password"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormError message={error} />
                                <FormSucess message={success} />

                                <Button
                                    disabled={isPending}
                                    type="submit"
                                    className="w-full"
                                    variant={"auth"}
                                >
                                    Change Password
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    );
}
interface Props {
    userId: string;
}
export function ChangeOtherPasswordForm({ userId }: Props) {
    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");
    const [isPending, setIsPending] = useState(false);
    const [open, setOpen] = useState(false);

    const form = useForm<z.infer<typeof ChangeOtherPasswordSchema>>({
        resolver: zodResolver(ChangeOtherPasswordSchema),
        defaultValues: {
            password: "",
            confirmPassword: ""
        }
    });

    const onSubmit = async (values: z.infer<typeof ChangeOtherPasswordSchema>) => {
        setError("");
        setSuccess("");
        setIsPending(true);

        try {

            const result = await newPasswordOtherProfile(userId, {
                password: values.password
            });

            if (result.error) {
                setError(result.error);
            }

            if (result.success) {
                setSuccess(result.success);
                form.reset();
                setOpen(false);
                setTimeout(() => {
                    setOpen(false)
                    window.location.reload()
                }, 1000)
            }
        } catch (error) {
            setError("Something went wrong!");
        } finally {
            setIsPending(false);
        }
    };

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="auth" size={"lg"}>
                    Change Password
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 bg-transparent border-none">
                <Card>
                    <CardHeader>
                        <CardTitle>Change Password</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                                <FormField
                                    control={form.control}
                                    name="password"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>New Password</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder="••••••••"
                                                    type="password"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="confirmPassword"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Confirm New Password</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    placeholder="••••••••"
                                                    type="password"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormError message={error} />
                                <FormSucess message={success} />

                                <Button
                                    disabled={isPending}
                                    type="submit"
                                    className="w-full"
                                    variant={"auth"}
                                >
                                    Change Password
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    );
}