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
import { undoSalaryIncrease } from "@/actions/superadmin/undo-increase-departmental-salary";

interface DeleteDeductionsDialogProps {
    salaryIncreaseId: string;
    isOpen: boolean;
    onOpenChange: (isOpen: boolean) => void;
}

export function UndoSalaryIncreaseDialog({ salaryIncreaseId, isOpen, onOpenChange }: DeleteDeductionsDialogProps) {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const handleOpenChange = (newOpen: boolean) => {
        onOpenChange(newOpen);
        if (!newOpen) {
            setTimeout(() => {
                window.location.reload();
            }, 300);
        }

    }

    const handleAction = async () => {
        setError("");
        setSuccess("");

        const result = await undoSalaryIncrease(salaryIncreaseId);
        if (result.error) {
            console.error(result.error);
            setError(result.error);
        } else {
            console.log(result.success);
            setSuccess(result.success);
            handleOpenChange(false);
            setTimeout(() => {
                window.location.reload();
            }, 300);
        }
    };

    return (
        <AlertDialog open={isOpen} onOpenChange={handleOpenChange}>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to undo this Salary Increase?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will undo the Salary Increase and any remaining information will be archived.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <AlertDialogAction asChild>
                        <Button onClick={handleAction} variant={"destructive"}>Undo</Button>
                    </AlertDialogAction>
                </AlertDialogFooter>
                <div>
                    <FormError message={error} />
                    <FormSucess message={success} />
                </div>
            </AlertDialogContent>
        </AlertDialog>
    );
}