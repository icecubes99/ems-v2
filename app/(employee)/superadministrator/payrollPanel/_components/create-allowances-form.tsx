import React, { useState } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'
import { EmployeeAllowanceSchema } from "@/schemas/payroll-index"
import { createAllowance } from '@/actions/superadmin/create-allowances'

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
    smallButton?: boolean
}

export default function CreateAllowances({ smallButton }: Props) {
    const [error, setError] = useState("")
    const [success, setSuccess] = useState("")
    const [isPending, setIsPending] = useState(false)
    const [open, setOpen] = useState(false)
    const [formattedAmount, setFormattedAmount] = useState("")
    const [dateISO, setDateISO] = useState("")

    const form = useForm<z.infer<typeof EmployeeAllowanceSchema>>({
        resolver: zodResolver(EmployeeAllowanceSchema),
        defaultValues: {
            userId: "",
            amount: 0,
            status: Status.ACTIVE,
            startDate: "",
            endDate: "",
            type: "",
        },
        mode: "onSubmit",
    })

    const onSubmit = async (values: z.infer<typeof EmployeeAllowanceSchema>) => {
        setError("")
        setSuccess("")
        setIsPending(true)

        const formattedValues = {
            ...values,
            startDate: new Date(values.startDate).toISOString(),
            endDate: new Date(values.endDate).toISOString(),
        }
        try {
            const data = await createAllowance(formattedValues)
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
    const today = new Date().toISOString().split('T')[0];

    const formatNumber = (num: number) => {
        return "₱" + num.toLocaleString('en-US')
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                {smallButton ? (
                    <Button variant="superadmin">Create Allowances</Button>
                ) : (
                    <Button variant="outline" className="h-auto py-4 flex flex-col items-center justify-center">
                        <Plus className="w-6 h-6 mb-2" />
                        Create Allowances
                    </Button>
                )}
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>Create Allowances for Employees</CardTitle>
                    </CardHeader>
                    <CardContent>

                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
                                <FormField
                                    control={form.control}
                                    name='userId'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Employees to Receive Additional Earnings</FormLabel>
                                            <FormControl>
                                                <SelectUser value={field.value} onUserChange={field.onChange} />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />


                                <FormField
                                    control={form.control}
                                    name="amount"
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


                                <FormField
                                    control={form.control}
                                    name='type'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Earnings Type</FormLabel>
                                            <Select
                                                disabled={isPending}
                                                onValueChange={field.onChange}
                                                value={field.value}
                                            >
                                                <FormControl>
                                                    <SelectTrigger>
                                                        <SelectValue placeholder="Select Earnings Type" />
                                                    </SelectTrigger>
                                                </FormControl>
                                                <SelectContent>
                                                    <SelectItem value="Educational Allowance">Educational Allowance</SelectItem>
                                                    <SelectItem value="Housing Allowance">Housing Allowance</SelectItem>
                                                    <SelectItem value="Transportation Allowance">Transportation Allowance</SelectItem>
                                                    <SelectItem value="Food Allowance">Food Allowance</SelectItem>
                                                    <SelectItem value="Clothing Allowance">Clothing Allowance</SelectItem>
                                                </SelectContent>
                                            </Select>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name='startDate'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Start Date</FormLabel>
                                            <FormControl>
                                                <input
                                                    type="date"
                                                    {...field}
                                                    id="start"
                                                    name="trip-start"
                                                    min={today}
                                                    disabled={isPending}
                                                    className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                                                    onChange={(e) => {
                                                        field.onChange(e);
                                                        setDateISO(new Date(e.target.value).toISOString());
                                                    }}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <FormField
                                    control={form.control}
                                    name='endDate'
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>End Date</FormLabel>
                                            <FormControl>
                                                <input
                                                    type="date"
                                                    {...field}
                                                    id="start"
                                                    name="trip-start"
                                                    min={today}
                                                    disabled={isPending}
                                                    className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                                                    onChange={(e) => {
                                                        field.onChange(e);
                                                        setDateISO(new Date(e.target.value).toISOString());
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
                                    Add Earnings
                                </Button>
                            </form>
                        </Form>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )


}