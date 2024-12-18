"use client"

import React, { useEffect, useState, useTransition } from 'react'
import * as z from 'zod';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { UserRole } from "@prisma/client";
import { EditIcon } from 'lucide-react';

import { ChangeUserRoleSchema } from "@/schemas/register-index";
import { changeUserRole } from '@/actions/superadmin/change-user-role';
import useUser from '@/hooks/use-user';

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";

import {
    Dialog,
    DialogContent,
    DialogTrigger
} from "@/components/ui/dialog";

import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select";

import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export const ChangeUserRoleDialog = ({ userId }: { userId: string }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const { user } = useUser(userId);

    const form = useForm<z.infer<typeof ChangeUserRoleSchema>>({
        resolver: zodResolver(ChangeUserRoleSchema),
        defaultValues: {
            userId: userId,
            role: user?.role || UserRole.USER
        }
    });

    useEffect(() => {
        if (user) {
            form.reset({
                userId: userId,
                role: user.role
            });
        }
    }, [user, form, userId]);

    const onSubmit = (values: z.infer<typeof ChangeUserRoleSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            changeUserRole(values)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }
                    if (data.success) {
                        setSuccess(data.success);
                        setTimeout(() => {
                            window.location.reload();
                        }, 300);
                    }
                })
                .catch(() => setError("Something went wrong!"));
        });
    };

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button size={"lg"} variant={"auth"}>
                    Change Role
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-[500px]'>
                    <CardHeader>
                        <CardTitle>
                            Change User Role
                        </CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name='role'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Role</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={field.onChange}
                                                defaultValue={field.value}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Select role" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value={UserRole.USER}>User</SelectItem>
                                                    <SelectItem value={UserRole.ADMIN}>Admin</SelectItem>
                                                    <SelectItem value={UserRole.SUPERADMIN}>Super Admin</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button
                                    // disabled={isPending}
                                    disabled
                                    type='submit'
                                    className='w-full'
                                    variant="auth"
                                >
                                    Change Role (Disabled)
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}