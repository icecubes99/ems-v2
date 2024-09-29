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
} from "@/components/ui/alert-dialog";
import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { approvePayroll } from "@/actions/superadmin/approve-payroll";
import { AlertDialogTrigger } from "@radix-ui/react-alert-dialog";
import { useRouter } from "next/navigation";
import { usePayroll } from "@/hooks/use-payroll-data";
import { LeaveStatus } from "@prisma/client";

interface ApprovePayrollDialogProps {
    payrollId: string;
}

export function ApprovePayrollDialog({ payrollId }: ApprovePayrollDialogProps) {
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

        const result = await approvePayroll(payrollId);
        if (result.error) {
            console.error(result.error);
            setError(result.error);
        } else {
            console.log(result.success);
            setSuccess(result.success);
            setTimeout(() => {
                // window.location.reload();
                router.push("/superadministrator/payrollPanel")
            }, 300);
        }
    };

    return (
        <AlertDialog open={open} onOpenChange={setOpen}>
            <AlertDialogTrigger asChild>
                <Button variant={"success"} disabled={payrollStatus === LeaveStatus.APPROVED}>Approve</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to approve this Payroll?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will approve the payroll and the employees will be able to view their payslips.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleAction} variant={"success"}>Approve</Button>
                </AlertDialogFooter>
                <div>
                    <FormError message={error} />
                    <FormSucess message={success} />
                </div>
            </AlertDialogContent>
        </AlertDialog>
    );
}