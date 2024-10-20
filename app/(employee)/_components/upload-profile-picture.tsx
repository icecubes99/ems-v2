"use client"

import React from 'react'
import * as z from 'zod'
import { useState, useTransition } from "react"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"

import { uploadProfilePicture } from '@/actions/upload-profile-pic'

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form"

import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { FormError } from "@/components/form-error"
import { FormSucess } from '@/components/form-sucess'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { Upload } from 'lucide-react'
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"

const ProfilePictureSchema = z.object({
    file: z.instanceof(File)
        .refine(file => file.size <= 5000000, `Max file size is 5MB.`)
        .refine(
            file => ['image/jpeg', 'image/png', 'image/webp'].includes(file.type),
            "Only .jpg, .png, and .webp formats are supported."
        )
})

export const UploadProfilePictureForm = ({ userId, initialProfilePicture }: { userId: string, initialProfilePicture?: string }) => {
    const [error, setError] = useState<string | undefined>("")
    const [success, setSuccess] = useState<string | undefined>("")
    const [isPending, startTransition] = useTransition()
    const [open, setOpen] = useState(false)
    const [preview, setPreview] = useState<string | null>(initialProfilePicture || null)

    const form = useForm<z.infer<typeof ProfilePictureSchema>>({
        resolver: zodResolver(ProfilePictureSchema),
    })

    const onSubmit = (values: z.infer<typeof ProfilePictureSchema>) => {
        setError("")
        setSuccess("")

        const formData = new FormData()
        formData.append('file', values.file)
        formData.append('userId', userId)

        startTransition(() => {
            uploadProfilePicture(formData)
                .then((data) => {
                    if (data.error) {
                        setError(data.error)
                    }
                    if (data.url) {
                        setSuccess("Profile picture uploaded successfully!")
                        setPreview(data.url)
                        setTimeout(() => {
                            setOpen(false)
                            window.location.reload()
                        }, 1000)
                    }
                })
                .catch(() => {
                    setError("An error occurred while uploading the profile picture.")
                })
        })
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button className='w-full' variant="outline">Upload Profile Picture</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card>
                    <CardHeader>
                        <CardTitle>Upload Profile Picture</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <div className="mb-4 flex justify-center">
                            <Avatar className="w-32 h-32">
                                <AvatarImage src={preview || '/placeholder.svg'} alt="Profile picture" />
                                <AvatarFallback>User</AvatarFallback>
                            </Avatar>
                        </div>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name='file'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Choose a picture</FormLabel>
                                            <FormControl>
                                                <Input
                                                    type="file"
                                                    accept="image/*"
                                                    disabled={isPending}
                                                    onChange={(e) => {
                                                        const file = e.target.files?.[0]
                                                        if (file) {
                                                            field.onChange(file)
                                                            const reader = new FileReader()
                                                            reader.onloadend = () => {
                                                                setPreview(reader.result as string)
                                                            }
                                                            reader.readAsDataURL(file)
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
                                        Upload Picture
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