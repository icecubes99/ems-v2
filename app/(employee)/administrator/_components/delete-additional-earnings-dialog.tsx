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
import { deleteAdditionalEarningsOfUser, deleteMultipleAdditionalEarningsOfUser } from "@/actions/superadmin/delete-additional-earnings";

interface DeleteAdditionalEarningsDialogProps {
    additionalEarningsId: string;
    isOpen: boolean;
    onOpenChange: (isOpen: boolean) => void;
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

export function DeleteAdditionalEarningsDialog({ additionalEarningsId, isOpen, onOpenChange, variant }: DeleteAdditionalEarningsDialogProps) {
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

        const result = await deleteAdditionalEarningsOfUser(additionalEarningsId);
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
                    <AlertDialogTitle>Are you sure you want to delete this Additional Earning?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will delete the Additional Earning and any remaining information will be lost.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <AlertDialogAction asChild>
                        <Button onClick={handleAction} variant={variant}>Delete</Button>
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

interface DeleteMultipleAdditionalEarningsDialogProps {
    additionalEarningsId: string[];
    isOpen: boolean;
    onOpenChange: (isOpen: boolean) => void;
    onDeleteComplete: () => void;
}



export function DeleteMultipleAdditionalEarningsDialog({ additionalEarningsId, isOpen, onOpenChange, onDeleteComplete }: DeleteMultipleAdditionalEarningsDialogProps) {
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");

    const handleAction = async () => {
        setError("");
        setSuccess("");

        const result = await deleteMultipleAdditionalEarningsOfUser(additionalEarningsId);
        if (result.error) {
            console.error(result.error);
            setError(result.error);
        } else {
            console.log(result.success);
            setSuccess(result.success);
            onDeleteComplete();
            setTimeout(() => {
                window.location.reload();
            }, 300);
        }
    };

    return (
        <AlertDialog open={isOpen} onOpenChange={onOpenChange}>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to delete these Additional Earnings?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will delete the Additional Earnings and any remaining information will be lost.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <AlertDialogAction asChild>
                        <Button onClick={handleAction} variant={"destructive"}>Delete</Button>
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