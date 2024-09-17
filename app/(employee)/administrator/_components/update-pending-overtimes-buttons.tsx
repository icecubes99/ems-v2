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
    AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Button } from "@/components/ui/button";
import { approveDenyOvertimes } from "@/actions/administrator/approve-deny-overtimes";
import { LeaveStatus } from "@prisma/client";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";

interface ApproveRejectOvertimeDialogProps {
    overtimeId: string;
}

export function ApproveOvertimeDialog({ overtimeId }: ApproveRejectOvertimeDialogProps) {
    const [open, setOpen] = useState(false);
    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");


    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const handleAction = async () => {
        setError("");
        setSuccess("");

        const result = await approveDenyOvertimes(overtimeId, { status: LeaveStatus.APPROVED });
        if (result.error) {
            console.error(result.error);
            setError(result.error);
        } else {
            console.log(result.success);
            setSuccess(result.success);
            handleOpenChange(false);
        }
    };

    return (
        <AlertDialog open={open} onOpenChange={setOpen}>
            <AlertDialogTrigger asChild>
                <Button variant="admin">Approve Overtime</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to approve this overtime?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will approve the overtime request and set the clock out time to 6:00 PM.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleAction} variant="superadmin">Approve</Button>
                </AlertDialogFooter>
                <div>
                    <FormError message={error} />
                    <FormSucess message={success} />
                </div>
            </AlertDialogContent>
        </AlertDialog>
    );
}

export function RejectOvertimeDialog({ overtimeId }: ApproveRejectOvertimeDialogProps) {

    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");
    const [open, setOpen] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }


    const handleAction = async () => {
        setError("");
        setSuccess("");
        const result = await approveDenyOvertimes(overtimeId, { status: LeaveStatus.REJECTED });
        if (result.error) {
            console.error(result.error);
            setError(result.error);
        } else {
            console.log(result.success);
            setSuccess(result.success);
            handleOpenChange(false);
        }
    };

    return (
        <AlertDialog open={open} onOpenChange={setOpen}>
            <AlertDialogTrigger asChild>
                <Button variant="destructive">Reject Overtime</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to reject this overtime?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will reject the overtime request.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleAction} variant="superadmin">Reject</Button>
                </AlertDialogFooter>
                <div>
                    <FormError message={error} />
                    <FormSucess message={success} />
                </div>
            </AlertDialogContent>
        </AlertDialog>
    );
}