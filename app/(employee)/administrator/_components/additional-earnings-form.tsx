import React, { useState } from 'react'
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from 'zod'

import { AdditionalEarningsSchema } from '@/schemas/payroll-index'
import { addAdditionalEarningsToUser } from '@/actions/superadmin/add-additional-earnings-to-user'
import { useUserList } from '@/hooks/use-user-list'

import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { FormError } from "@/components/form-error"
import { FormSucess } from "@/components/form-sucess"
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'
import { Textarea } from '@/components/ui/textarea'
import { LiteMultiSelect } from '@/components/ui/lite-multi-select'

interface AdditionalEarningsFormProps {
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

export default function AddAdditionalEarningsForm({ variant }: AdditionalEarningsFormProps) {
    const [error, setError] = useState("")
    const [success, setSuccess] = useState("")
    const [isPending, setIsPending] = useState(false)
    const [open, setOpen] = useState(false)
    const [formattedAmount, setFormattedAmount] = useState("")

    const { users } = useUserList()

    const userOptions = users?.map((user) => ({
        value: user.id,
        label: `${user.firstName} ${user.lastName}`
    })) || []

    const form = useForm<z.infer<typeof AdditionalEarningsSchema>>({
        resolver: zodResolver(AdditionalEarningsSchema),
        defaultValues: {
            userIds: [],
            earningType: "",
            amount: 0,
            description: "",
        },
        mode: "onSubmit",
    })

    const onSubmit = async (values: z.infer<typeof AdditionalEarningsSchema>) => {
        setError("")
        setSuccess("")
        setIsPending(true)

        try {
            const data = await addAdditionalEarningsToUser(values)
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
                    Add Additional Earnings
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-auto bg-transparent border-none'>
                <Card className='w-96'>
                    <CardHeader>
                        <CardTitle>Add Additional Earnings to Employees</CardTitle>
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
                                                <FormLabel>Employees to Receive Additional Earnings</FormLabel>
                                                <FormControl>
                                                    <LiteMultiSelect
                                                        options={userOptions}
                                                        onChange={(values) => field.onChange(values)}
                                                        placeholder="Select users"
                                                        itemName='user'
                                                    />
                                                </FormControl>
                                                <FormMessage />
                                            </FormItem>
                                        )}
                                    />

                                    <FormField
                                        control={form.control}
                                        name='earningType'
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
                                                        <SelectItem value="Bonus">Bonus</SelectItem>
                                                        <SelectItem value="Overtime">Overtime</SelectItem>
                                                        <SelectItem value="Commission">Commission</SelectItem>
                                                        <SelectItem value="Allowance">Allowance</SelectItem>
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