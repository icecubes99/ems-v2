"use client"

import React from 'react'
import * as z from 'zod'
import { useState, useTransition } from "react"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"

import { uploadDocument } from '@/actions/upload-documents'

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { FormError } from "@/components/form-error"
import { FormSucess } from './form-sucess'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { Plus, Upload } from 'lucide-react'
import { useCurrentUser } from '@/hooks/use-current-user'

const DocumentSchema = z.object({
    documentName: z.string().min(1, "Document name is required"),
    documentType: z.string().min(1, "Document type is required"),
    file: z.instanceof(File)
        .refine(file => file.size <= 10000000, `Max file size is 10MB.`)
        .refine(
            file => [
                'application/pdf',
                'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                'image/jpeg',
                'image/png',
                'image/svg+xml'
            ].includes(file.type),
            "Only .pdf, .doc, .docx, .jpg, .png, and .svg formats are supported."
        )
})

export const UploadDocumentForm = () => {
    const user = useCurrentUser()
    if (!user) {
        return (
            <div>What</div>
        )
    }
    const userId = user.id as string
    const [error, setError] = useState<string | undefined>("")
    const [success, setSuccess] = useState<string | undefined>("")
    const [isPending, startTransition] = useTransition()
    const [open, setOpen] = useState(false)

    const form = useForm<z.infer<typeof DocumentSchema>>({
        resolver: zodResolver(DocumentSchema),
        defaultValues: {
            documentName: "",
            documentType: "",
        }
    })

    const onSubmit = (values: z.infer<typeof DocumentSchema>) => {
        setError("")
        setSuccess("")

        const formData = new FormData()
        formData.append('file', values.file)
        formData.append('userId', userId)
        formData.append('documentName', values.documentName)
        formData.append('documentType', values.documentType)

        startTransition(() => {
            uploadDocument(formData)
                .then((data) => {
                    if (data.error) {
                        setError(data.error)
                    }
                    if (data.documentLink) {
                        setSuccess("Document uploaded successfully!")
                        form.reset()
                        setTimeout(() => {
                            setOpen(false)
                            window.location.reload()
                        }, 1000)
                    }
                })
                .catch(() => {
                    setError("An error occurred while uploading the document.")
                })
        })
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant={"outline"} size={"lg"}
                    className={("h-auto w-full py-4 flex flex-col items-center justify-center")}>
                    <Plus className="w-6 h-6 mb-2" />
                    Upload Documents
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-[850px] bg-transparent border-none'>
                <Card>
                    <CardHeader>
                        <CardTitle>Upload Document</CardTitle>
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
                                <FormField
                                    control={form.control}
                                    name='file'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Choose a document</FormLabel>
                                            <FormControl>
                                                <Input
                                                    type="file"
                                                    accept=".pdf,.doc,.docx,.jpg,.jpeg,.png,.svg"
                                                    disabled={isPending}
                                                    onChange={(e) => {
                                                        const file = e.target.files?.[0]
                                                        if (file) {
                                                            field.onChange(file)
                                                        }
                                                    }}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <div className='mt-4 gap-2 flex-col flex'>
                                    <FormError message={error} />
                                    <FormSucess message={success} />
                                    <Button disabled={isPending} type='submit' className='w-full'>
                                        <Upload className="mr-2 h-4 w-4" />
                                        Upload Document
                                    </Button>
                                </div>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}