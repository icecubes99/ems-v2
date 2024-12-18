"use client"
import React, { useState, useTransition } from 'react'
import * as z from 'zod';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { archiveUser } from '@/actions/superadmin/remove/archive-user';

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

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import useUser from '@/hooks/use-user';
import { Archive } from 'lucide-react';

const ArchiveUserSchema = z.object({
    email: z.string().email("Invalid email address"),
});

export const ArchiveUserDialog = ({ userId }: { userId: string }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();
    const { user } = useUser(userId);
    const [open, setOpen] = useState(false);

    const form = useForm<z.infer<typeof ArchiveUserSchema>>({
        resolver: zodResolver(ArchiveUserSchema),
        defaultValues: {
            email: "",
        }
    });

    const onSubmit = (values: z.infer<typeof ArchiveUserSchema>) => {
        if (!user) return;

        if (values.email !== user.email) {
            setError("Email does not match user's email");
            return;
        }

        setError("");
        setSuccess("");

        startTransition(() => {
            archiveUser(userId)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }
                    if (data.success) {
                        setSuccess(data.success);
                        setOpen(false);
                        setTimeout(() => {
                            window.location.reload();
                        }, 300);
                    }
                })
                .catch(() => setError("Something went wrong!"));
        });
    };

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button
                    size="lg"
                    variant="destructive"
                >
                    <Archive className='w-4 h-4' />
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-[500px]'>
                    <CardHeader>
                        <CardTitle>
                            Archive User
                        </CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <div className="space-y-4">
                                    <p className="text-sm text-muted-foreground">
                                        To archive this user, please enter their email address:
                                        <span className="font-semibold text-foreground"> {user?.email}</span>
                                    </p>
                                    <FormField
                                        control={form.control}
                                        name='email'
                                        render={({ field }) => (
                                            <FormItem>
                                                <FormLabel>Email</FormLabel>
                                                <FormControl>
                                                    <Input
                                                        {...field}
                                                        disabled={isPending}
                                                        placeholder="Enter user email"
                                                        type="email"
                                                    />
                                                </FormControl>
                                                <FormMessage />
                                            </FormItem>
                                        )}
                                    />
                                </div>

                                <FormError message={error} />
                                <FormSucess message={success} />

                                <Button
                                    // disabled={isPending}
                                    disabled
                                    type='submit'
                                    className='w-full'
                                    variant="destructive"
                                >
                                    Archiving Feature Disabled
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}