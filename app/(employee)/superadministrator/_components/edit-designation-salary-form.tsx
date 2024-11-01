"use client"
import React, { useState } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'

import { editDesignationSalary } from '@/actions/superadmin/edit-designation-salary'
import { EditDesignationSalarySchema } from '@/schemas/payroll-index'

import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { FormError } from "@/components/form-error"
import { FormSucess } from "@/components/form-sucess"
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { Textarea } from '@/components/ui/textarea'
import { MultiSelectUsers } from '@/components/ui/multi-select-components'
import { Plus } from 'lucide-react'
import { Status } from '@prisma/client'
import SelectUser from '@/app/(employee)/_components/SelectUser'
import Link from 'next/link'

interface Props {
    designationId: string
}
export default function EditDesignationSalaryForm({ designationId }: Props) {
    const [error, setError] = useState("")
    const [success, setSuccess] = useState("")
    const [isPending, setIsPending] = useState(false)
    const [open, setOpen] = useState(false)
    const [formattedAmount, setFormattedAmount] = useState("")

    const form = useForm<z.infer<typeof EditDesignationSalarySchema>>({
        resolver: zodResolver(EditDesignationSalarySchema),
        defaultValues: {
            designationId,
            newSalary: 0,
        }
    })

    const onSubmit = async (values: z.infer<typeof EditDesignationSalarySchema>) => {
        setError("")
        setSuccess("")
        setIsPending(true)

        try {
            const data = await editDesignationSalary(values)
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
    }
    const formatNumber = (num: number) => {
        return "₱" + num.toLocaleString('en-US')
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="superadmin" className="w-full">Edit Designation Salary</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>Edit Designation Salary</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>

                                <FormField
                                    control={form.control}
                                    name="newSalary"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Amount</FormLabel>
                                            <FormControl>
                                                <Input
                                                    disabled={isPending}
                                                    type="text"
                                                    placeholder="₱0"
                                                    value={formattedAmount}
                                                    onChange={(e) => {
                                                        const value = e.target.value.replace(/[^0-9]/g, '')
                                                        const numberValue = parseInt(value, 10)
                                                        const formatted = formatNumber(numberValue || 0)
                                                        setFormattedAmount(formatted)
                                                        field.onChange(numberValue || 0)
                                                    }}
                                                    onFocus={(e) => {
                                                        e.target.setSelectionRange(e.target.value.length, e.target.value.length)
                                                    }}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant={"superadmin"} disabled={isPending} type='submit' className='w-full'>
                                    Update Salary
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}

