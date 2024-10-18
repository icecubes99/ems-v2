import React, { useState } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'

import { DeductionsSchema } from '@/schemas/payroll-index'
import { addDeductionsToUsers } from '@/actions/superadmin/addDeductionsToUser'

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

interface DeductionsFormProps {
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

export default function AddDeductionsForm({ variant }: DeductionsFormProps) {
    const [error, setError] = useState("")
    const [success, setSuccess] = useState("")
    const [isPending, setIsPending] = useState(false)
    const [open, setOpen] = useState(false)
    const [formattedSalary, setFormattedSalary] = useState("")

    const form = useForm<z.infer<typeof DeductionsSchema>>({
        resolver: zodResolver(DeductionsSchema),
        defaultValues: {
            userIds: [],
            deductionType: "",
            amount: 0,
            description: "",
        },
        mode: "onSubmit",
    })

    const onSubmit = async (values: z.infer<typeof DeductionsSchema>) => {
        setError("")
        setSuccess("")
        setIsPending(true)

        try {
            const data = await addDeductionsToUsers(values)
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
                <Button size="lg" className='w-full' variant={variant}>
                    Add Deductions
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>Add Deductions to Employees</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <div className='space-y-4'>
                                    <FormField
                                        control={form.control}
                                        name='userIds'
                                        render={({ field }) => (
                                            <FormItem>
                                                <FormLabel>Employees to be Deducted</FormLabel>
                                                <FormControl>
                                                    <MultiSelectUsers
                                                        onChange={(values) => field.onChange(values)}
                                                    />
                                                </FormControl>
                                                <FormMessage />
                                            </FormItem>
                                        )}
                                    />

                                    <FormField
                                        control={form.control}
                                        name='deductionType'
                                        render={({ field }) => (
                                            <FormItem>
                                                <FormLabel>Deduction Type</FormLabel>
                                                <Select
                                                    disabled={isPending}
                                                    onValueChange={field.onChange}
                                                    value={field.value}
                                                >
                                                    <FormControl>
                                                        <SelectTrigger>
                                                            <SelectValue placeholder="Pick the Type" />
                                                        </SelectTrigger>
                                                    </FormControl>
                                                    <SelectContent>
                                                        <SelectItem value="Disbursement">Disbursement</SelectItem>
                                                        <SelectItem value="Salary Advance">Salary Advance</SelectItem>
                                                        <SelectItem value="Loan">Loan</SelectItem>
                                                        <SelectItem value="Others">Others</SelectItem>
                                                    </SelectContent>
                                                </Select>
                                                <FormMessage />
                                            </FormItem>
                                        )}
                                    />

                                    <FormField
                                        control={form.control}
                                        name="amount"
                                        render={({ field }) => (
                                            <FormItem>
                                                <FormLabel>Amount Deducted</FormLabel>
                                                <FormControl>
                                                    <Input
                                                        disabled={isPending}
                                                        type="text"
                                                        placeholder="₱0"
                                                        value={formattedSalary}
                                                        onChange={(e) => {
                                                            const value = e.target.value.replace(/[^0-9]/g, '')
                                                            const numberValue = parseInt(value, 10)
                                                            const formatted = formatNumber(numberValue || 0)
                                                            setFormattedSalary(formatted)
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

                                    <FormField
                                        control={form.control}
                                        name='description'
                                        render={({ field }) => (
                                            <FormItem>
                                                <FormLabel>Description</FormLabel>
                                                <FormControl>
                                                    <Textarea
                                                        {...field}
                                                        disabled={isPending}
                                                        placeholder='Enter description'
                                                    />
                                                </FormControl>
                                                <FormMessage />
                                            </FormItem>
                                        )}
                                    />
                                </div>

                                <FormError message={error} />
                                <FormSucess message={success} />
                                <Button variant={variant} disabled={isPending} type='submit' className='w-full'>
                                    Deduct Amount
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}