"use client";

import * as z from "zod";
import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { newRegisterSchema } from "@/schemas/register-index";

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
import { register } from "@/actions/register";

import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Gender, UserRole, EmployeeType, Status } from "@prisma/client";
import SelectDesignation from "../../_components/select-designations";
import { newRegister } from "@/actions/superadmin/new-register";

const NewRegisterForm = () => {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [isPending, startTransition] = useTransition();
    // const [birthDateISO, setBirthDateISO] = useState('');

    const form = useForm<z.infer<typeof newRegisterSchema>>({
        resolver: zodResolver(newRegisterSchema),
        defaultValues: {
            email: "",
            password: "",
            firstName: "",
            middleName: "",
            lastName: "",
            gender: Gender.OTHER,
            birthDate: "",
            role: UserRole.USER,
            jobTitle: "",
            designationId: "",
            employeeType: EmployeeType.REGULAR,
            status: Status.ACTIVE,
            basicSalary: 0,
            sssNumber: "",
            tinNumber: "",
            philHealthNumber: "",
            pagIbigNumber: "",
        },
    });

    const onSubmit = (values: z.infer<typeof newRegisterSchema>) => {
        setError("");
        setSuccess("");

        // Format the birthDate to ISO-8601 DateTime string
        const formattedValues = {
            ...values,
            birthDate: new Date(values.birthDate).toISOString(),
        };

        startTransition(() => {
            newRegister(formattedValues).then((data) => {
                setError(data.error);
                setSuccess(data.success);
            });
        });
    };

    return (
        <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6 mt-5 mb-5">
                <div className="space-y-4">
                    {/* Personal Information */}
                    <div className="grid grid-cols-3 gap-4">
                        <FormField
                            control={form.control}
                            name="firstName"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>First Name</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="John" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="middleName"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Middle Name</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="Doe" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="lastName"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Last Name</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="Smith" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                    </div>

                    {/* Email and Password */}
                    <FormField
                        control={form.control}
                        name="email"
                        render={({ field }) => (
                            <FormItem>
                                <FormLabel>Email</FormLabel>
                                <FormControl>
                                    <Input {...field} disabled={isPending} type="email" placeholder="john.doe@example.com" />
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}
                    />
                    <FormField
                        control={form.control}
                        name="password"
                        render={({ field }) => (
                            <FormItem>
                                <FormLabel>Password</FormLabel>
                                <FormControl>
                                    <Input {...field} disabled={isPending} type="password" placeholder="******" />
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}
                    />

                    {/* Gender and Birth Date */}
                    <div className="grid grid-cols-2 gap-4">
                        <FormField
                            control={form.control}
                            name="gender"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Gender</FormLabel>
                                    <Select disabled={isPending} onValueChange={field.onChange} defaultValue={field.value}>
                                        <FormControl>
                                            <SelectTrigger>
                                                <SelectValue placeholder="Select Gender" />
                                            </SelectTrigger>
                                        </FormControl>
                                        <SelectContent>
                                            <SelectItem value={Gender.MALE}>Male</SelectItem>
                                            <SelectItem value={Gender.FEMALE}>Female</SelectItem>
                                            <SelectItem value={Gender.OTHER}>Other</SelectItem>
                                        </SelectContent>
                                    </Select>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        {/* Birth Date */}
                        <FormField
                            control={form.control}
                            name="birthDate"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Birth Date</FormLabel>
                                    <FormControl>
                                        <Input
                                            {...field}
                                            disabled={isPending}
                                            type="date"
                                            onChange={(e) => field.onChange(e.target.value)}
                                        />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                    </div>

                    {/* Role and Job Title */}
                    <div className="grid grid-cols-2 gap-4">
                        <FormField
                            control={form.control}
                            name="role"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Role</FormLabel>
                                    <Select disabled={isPending} onValueChange={field.onChange} defaultValue={field.value}>
                                        <FormControl>
                                            <SelectTrigger>
                                                <SelectValue placeholder="Select Role" />
                                            </SelectTrigger>
                                        </FormControl>
                                        <SelectContent>
                                            <SelectItem value={UserRole.USER}>User</SelectItem>
                                            <SelectItem value={UserRole.ADMIN}>Admin</SelectItem>
                                            <SelectItem value={UserRole.SUPERADMIN}>Super Admin</SelectItem>
                                        </SelectContent>
                                    </Select>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="jobTitle"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Job Title</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="Software Engineer" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                    </div>

                    {/* Designation, Employee Type, and Status */}
                    <div className="grid grid-cols-3 gap-4">
                        <FormField
                            control={form.control}
                            name="designationId"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Designation</FormLabel>
                                    <SelectDesignation onUserChange={field.onChange} />
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="employeeType"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Employee Type</FormLabel>
                                    <Select disabled={isPending} onValueChange={field.onChange} defaultValue={field.value}>
                                        <FormControl>
                                            <SelectTrigger>
                                                <SelectValue placeholder="Select Type" />
                                            </SelectTrigger>
                                        </FormControl>
                                        <SelectContent>
                                            <SelectItem value={EmployeeType.REGULAR}>Regular</SelectItem>
                                            <SelectItem value={EmployeeType.CONTRACTUAL}>Contractual</SelectItem>
                                            <SelectItem value={EmployeeType.PROBATIONARY}>Probationary</SelectItem>
                                        </SelectContent>
                                    </Select>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="status"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Status</FormLabel>
                                    <Select disabled={isPending} onValueChange={field.onChange} defaultValue={field.value}>
                                        <FormControl>
                                            <SelectTrigger>
                                                <SelectValue placeholder="Select Status" />
                                            </SelectTrigger>
                                        </FormControl>
                                        <SelectContent>
                                            <SelectItem value={Status.ACTIVE}>Active</SelectItem>
                                            <SelectItem value={Status.INACTIVE}>Inactive</SelectItem>
                                        </SelectContent>
                                    </Select>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                    </div>


                    {/* Basic Salary */}
                    <FormField
                        control={form.control}
                        name="basicSalary"
                        render={({ field }) => (
                            <FormItem>
                                <FormLabel>Basic Salary</FormLabel>
                                <FormControl>
                                    <Input
                                        {...field}
                                        disabled={isPending}
                                        type="number"
                                        placeholder="0.00"
                                        onChange={(e) => field.onChange(parseFloat(e.target.value))}
                                    />
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}
                    />

                    {/* Government IDs */}
                    <div className="grid grid-cols-2 gap-4">
                        <FormField
                            control={form.control}
                            name="sssNumber"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>SSS Number</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="SSS Number" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="tinNumber"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>TIN Number</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="TIN Number" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="philHealthNumber"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>PhilHealth Number</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="PhilHealth Number" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="pagIbigNumber"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Pag-IBIG Number</FormLabel>
                                    <FormControl>
                                        <Input {...field} disabled={isPending} placeholder="Pag-IBIG Number" />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                    </div>
                </div>
                <FormError message={error} />
                <FormSucess message={success} />
                <Button variant={"superadmin"} disabled={isPending} type="submit" className="w-full">
                    Create Account
                </Button>
            </form>
        </Form>
    );
};

export default NewRegisterForm;