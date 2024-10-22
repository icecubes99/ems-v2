"use client"
import React, { useEffect, useRef, useState, useTransition } from 'react'
import * as z from 'zod';
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { DocumentsSchema, UpdateDocumentsSchema } from '@/schemas';
import { updateDocuments } from '@/actions/update-documents';

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
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { useSingleDocument } from '@/hooks/use-documents';
import { EditIcon } from 'lucide-react';



export const UpdateDocumentsDialog = ({ documentId }: { documentId: string }) => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();

    const { document } = useSingleDocument(documentId);

    const form = useForm<z.infer<typeof UpdateDocumentsSchema>>({
        resolver: zodResolver(UpdateDocumentsSchema),
        defaultValues: {
            documentName: "",
            documentType: "",
            documentLink: "",
        }
    })

    useEffect(() => {
        if (document) {
            form.reset(document);
        }
    }, [document, form])

    const onSubmit = (values: z.infer<typeof UpdateDocumentsSchema>) => {
        setError("");
        setSuccess("");

        startTransition(() => {
            updateDocuments(values)
                .then((data) => {
                    if (data.error) {
                        setError(data.error);
                    }

                    if (data.success) {
                        setSuccess(data.success);
                        setTimeout(() => {
                            window.location.reload();
                        }, 300)
                    }
                })
                .catch(() => setError("An error occurred!"));
        });
    };

    return (
        <Dialog>
            <DialogTrigger>
                <Button variant="sidebar">
                    <EditIcon className='h-4 w-4' />
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-[500px]'>
                    <CardHeader>
                        Edit Document Details
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name='documentName'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Document Name</FormLabel>
                                            <FormControl>
                                                <Input {...field} disabled={isPending} />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name='documentType'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Document Type</FormLabel>
                                            <FormControl>
                                                <Select
                                                    disabled={isPending}
                                                    onValueChange={field.onChange}
                                                    defaultValue={field.value}
                                                >
                                                    <FormControl>
                                                        <SelectTrigger>
                                                            <SelectValue placeholder="Pick the Document Type" />
                                                        </SelectTrigger>
                                                    </FormControl>
                                                    <SelectContent>
                                                        <SelectItem value={"PDF"}>PDF Document (.pdf)</SelectItem>
                                                        <SelectItem value={"Word"}>Word Document (.doc)</SelectItem>
                                                        <SelectItem value={"WordOpenXML"}>Word Document (.docx)</SelectItem>
                                                        <SelectItem value={"JPEG"}>JPEG Image (.jpg)</SelectItem>
                                                        <SelectItem value={"PNG"}>PNG Image (.png)</SelectItem>
                                                        <SelectItem value={"SVG"}>SVG Image (.svg)</SelectItem>
                                                    </SelectContent>
                                                </Select>
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button disabled={isPending} variant={"auth"} type='submit' className='w-full'>
                                    Save Document
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>

            </DialogContent>
        </Dialog>
    )
}