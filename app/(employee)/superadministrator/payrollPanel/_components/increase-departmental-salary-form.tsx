"use client"

import React, { useState, useTransition } from 'react'
import * as z from 'zod'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"

import { IncreaseDepartmentSalarySchema } from '@/schemas/payroll-index'
import { increaseDepartmentSalary } from '@/actions/superadmin/increase-departmental-salary'

import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form"

import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { FormError } from "@/components/form-error"
import { FormSucess } from "@/components/form-sucess"
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'

import { MultiSelectDepartments } from '@/components/ui/multi-select-components'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { ChevronUp } from 'lucide-react'

export default function IncreaseDepartmentalSalaryForm() {
    const [error, setError] = useState<string | undefined>("")
    const [success, setSuccess] = useState<string | undefined>("")
    const [isPending, startTransition] = useTransition()
    const [open, setOpen] = useState(false)
    const [formattedSalary, setFormattedSalary] = useState("")
    const [increaseType, setIncreaseType] = useState("amount")

    const formatNumber = (num: number) => {
        return "₱" + num.toLocaleString('en-US')
    }

    const formatPercentage = (num: number) => {
        return num.toString() + "%"
    }

    const form = useForm<z.infer<typeof IncreaseDepartmentSalarySchema>>({
        resolver: zodResolver(IncreaseDepartmentSalarySchema),
        defaultValues: {
            departmentIds: [],
            value: 0,
        },
    })

    const onSubmit = (values: z.infer<typeof IncreaseDepartmentSalarySchema>) => {
        setError("")
        setSuccess("")

        startTransition(() => {
            increaseDepartmentSalary(values)
                .then((data) => {
                    if (data.error) {
                        setError(data.error)
                    }

                    if (data.success) {
                        setSuccess(data.success)
                        setTimeout(() => {
                            window.location.reload()
                        }, 300)
                    }
                })
                .catch(() => setError("An error occurred!"))
        })
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                <Button variant="outline" className="h-auto py-4 flex flex-col items-center justify-center">
                    <ChevronUp className="w-6 h-6 mb-2" />
                    Increase Departmental Salary
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card>
                    <CardHeader>
                        <CardTitle>Increase the Salary of entire Departments</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name='departmentIds'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Departments</FormLabel>
                                            <FormControl>
                                                <MultiSelectDepartments
                                                    onChange={field.onChange} />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name='increaseType'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Additional Earning Type</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={(value) => {
                                                    field.onChange(value)
                                                    setIncreaseType(value)
                                                }}
                                                defaultValue={field.value}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Pick the Type" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value="percentage">Percentage</SelectItem>
                                                    <SelectItem value="amount">Exact Amount</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name="value"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Amount Added</FormLabel>
                                            <FormControl>
                                                <Input
                                                    {...field}
                                                    disabled={isPending}
                                                    type="text"
                                                    placeholder={increaseType === "amount" ? "₱0" : "0%"}
                                                    value={formattedSalary}
                                                    onChange={(e) => {
                                                        const value = e.target.value.replace(/[^0-9]/g, '')
                                                        const numberValue = parseInt(value, 10)
                                                        const formatted = increaseType === "amount" ? formatNumber(numberValue || 0) : formatPercentage(numberValue || 0)
                                                        setFormattedSalary(formatted)
                                                        field.onChange(numberValue || 0)
                                                    }}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant="superadmin" disabled={isPending} type='submit' className='w-full'>
                                    Increase Salary
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}