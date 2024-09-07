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
import { approveDenyLeaves } from "@/actions/administrator/approve-deny-leaves";
import { LeaveStatus } from "@prisma/client";

interface ApproveRejectLeaveDialogProps {
    leaveId: string;
}

export function ApproveLeaveDialog({ leaveId }: ApproveRejectLeaveDialogProps) {
    const [open, setOpen] = useState(false);
    const [actionType, setActionType] = useState<LeaveStatus | null>(null);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const handleAction = async (leaveStatus: LeaveStatus) => {
        const result = await approveDenyLeaves(leaveId, { leaveStatus });
        if (result.error) {
            console.error(result.error);
        } else {
            console.log(result.success);
            handleOpenChange(false);
        }
    };

    return (
        <AlertDialog open={open} onOpenChange={setOpen}>
            <AlertDialogTrigger asChild>
                <Button variant={"admin"} onClick={() => setActionType(LeaveStatus.APPROVED)}>Approve Leave</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you sure you want to approve this leave?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will approve the leave request.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={() => handleAction(LeaveStatus.APPROVED)} variant={"superadmin"}>Approve</Button>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
    );
}

export function RejectLeaveDialog({ leaveId }: ApproveRejectLeaveDialogProps) {
    const [open, setOpen] = useState(false);
    const [actionType, setActionType] = useState<LeaveStatus | null>(null);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const handleAction = async (leaveStatus: LeaveStatus) => {
        const result = await approveDenyLeaves(leaveId, { leaveStatus });
        if (result.error) {
            console.error(result.error);
        } else {
            console.log(result.success);
            handleOpenChange(false);
        }
    };

    return (
        <>
            <AlertDialog open={open} onOpenChange={setOpen}>
                <AlertDialogTrigger asChild>
                    <Button variant={"destructive"} onClick={() => setActionType(LeaveStatus.REJECTED)}>Reject Leave</Button>
                </AlertDialogTrigger>
                <AlertDialogContent>
                    <AlertDialogHeader>
                        <AlertDialogTitle>Are you sure you want to reject this leave?</AlertDialogTitle>
                        <AlertDialogDescription>
                            This action cannot be undone. This will reject the leave request.
                        </AlertDialogDescription>
                    </AlertDialogHeader>
                    <AlertDialogFooter>
                        <AlertDialogCancel>Cancel</AlertDialogCancel>
                        <Button onClick={() => handleAction(LeaveStatus.REJECTED)} variant={"superadmin"}>Reject</Button>
                    </AlertDialogFooter>
                </AlertDialogContent>
            </AlertDialog>
        </>
    );
}