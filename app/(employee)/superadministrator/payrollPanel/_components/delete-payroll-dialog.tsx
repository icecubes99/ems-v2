"use client"

import React, { useState } from "react";
import {
    AlertDialog,
    AlertDialogAction,
    AlertDialogCancel,
    AlertDialogContent,
    AlertDialogDescription,
    AlertDialogFooter,
    AlertDialogHeader,
    AlertDialogTitle,
    AlertDialogTrigger
} from "@/components/ui/alert-dialog";
import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { removePayroll } from "@/actions/superadmin/remove/remove-payroll";
import { useRouter } from "next/navigation";
import { usePayroll } from "@/hooks/use-payroll-data";
import { LeaveStatus } from "@prisma/client";

interface DeletePayrollDialogProps {
    payrollId: string;
}

export function DeletePayrollDialog({ payrollId }: DeletePayrollDialogProps) {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const { payroll } = usePayroll(payrollId);
    const payrollStatus = payroll?.payrollStatus;

    const [open, setOpen] = useState(false);

    const router = useRouter()

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            router.push("/superadministrator/payrollPanel")
        }
    }

    const handleAction = async () => {
        setError("");
        setSuccess("");

        const result = await removePayroll(payrollId);
        if (result.error) {
            console.error(result.error);
            setError(result.error);
        } else {
            console.log(result.success);
            setSuccess(result.success);
            setTimeout(() => {

                router.push("/superadministrator/payrollPanel")
            }, 300);
        }
    };

    return (
        <AlertDialog open={open} onOpenChange={setOpen}>
            <AlertDialogTrigger asChild>
                <Button className="w-36" variant={"destructive"} disabled={payrollStatus === LeaveStatus.APPROVED}>Delete</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to delete this Payroll?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will delete the payroll and the data will be lost.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleAction} variant={"destructive"}>Delete</Button>
                </AlertDialogFooter>
                <div>
                    <FormError message={error} />
                    <FormSucess message={success} />
                </div>
            </AlertDialogContent>
        </AlertDialog>
    );
}