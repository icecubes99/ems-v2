"use client"

import React, { useState, useEffect } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'

import { EditUserBaseSalarySchema } from '@/schemas/payroll-index'
import { editUserBaseSalary } from '@/actions/superadmin/edit-base-salary'
import { useBaseSalary } from '@/hooks/use-salary'


import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { FormError } from "@/components/form-error"
import { FormSucess } from "@/components/form-sucess"
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { formatPeso } from '@/lib/format'

interface Props {
    userId: string
}

export const EditBaseSalaryDialog = ({ userId }: Props) => {
    const [error, setError] = useState("")
    const [success, setSuccess] = useState("")
    const [isPending, setIsPending] = useState(false)
    const [open, setOpen] = useState(false)
    const [grossSalary, setGrossSalary] = useState(0)
    const [formattedAmount, setFormattedAmount] = useState("")
    const { baseSalary } = useBaseSalary(userId)

    const form = useForm<z.infer<typeof EditUserBaseSalarySchema>>({
        resolver: zodResolver(EditUserBaseSalarySchema),
        defaultValues: {
            userId: userId,
            newBaseSalary: baseSalary?.basicSalary || 0,
        }
    })

    useEffect(() => {
        if (baseSalary) {
            form.reset({
                userId,
                newBaseSalary: baseSalary.basicSalary
            });
            setFormattedAmount(formatPeso(baseSalary.basicSalary))
        }
    }, [baseSalary, form, userId])

    const onSubmit = async (values: z.infer<typeof EditUserBaseSalarySchema>) => {
        setError("")
        setSuccess("")
        setIsPending(true)

        try {
            const data = await editUserBaseSalary({
                ...values,
            })
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

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="auth" size="lg">Edit Base Salary</Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-[400px]'>
                    <CardHeader>
                        <CardTitle>Edit Base Salary</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <div className="space-y-4">
                                    <FormField
                                        control={form.control}
                                        name="newBaseSalary"
                                        render={({ field }) => (
                                            <FormItem>
                                                <FormLabel>New Base Salary</FormLabel>
                                                <FormControl>
                                                    <Input
                                                        {...field}
                                                        disabled={isPending}
                                                        type="number"
                                                        placeholder="Enter new base salary"
                                                        onChange={(e) => field.onChange(parseFloat(e.target.value))}
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
                                    disabled={isPending}
                                    type="submit"
                                    variant="superadmin"
                                    className="w-full"
                                >
                                    Update Base Salary
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}