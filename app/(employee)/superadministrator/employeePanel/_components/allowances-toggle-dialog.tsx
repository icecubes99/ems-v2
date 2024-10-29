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
import { removeAssignedUser } from "@/actions/superadmin/removeAssignedUser";
import { removeDocuments } from "@/actions/remove-documents";
import { Plus, Trash, X } from "lucide-react";
import { toggleAllowanceStatus } from "@/actions/superadmin/create-allowances";
import { removeAllowance } from "@/actions/superadmin/remove/remove-allowance";

interface Props {
    allowanceId: string;
    variant?: "active" | "inactive";
}

export function ToggleAllowanceInactive({ allowanceId, variant }: Props) {
    const [allowanceIds, setAllowanceIds] = useState(allowanceId);

    const [open, setOpen] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const handleDelete = async () => {
        const result = await toggleAllowanceStatus(allowanceIds);
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
                {variant === "active" ? <Button variant={"destructive"}>
                    <X className="h-4 w-4" />
                </Button> :
                    <Button variant={"success"}>
                        <Plus className="h-4 w-4" />
                    </Button>}
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This will change the status of the allowance from active to inactive or vice versa.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleDelete} variant={"auth"}>Toggle</Button>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
    );
}

export function RemoveAllowanceDialog({ allowanceId }: Props) {
    const [allowanceIds, setAllowanceIds] = useState(allowanceId);

    const [open, setOpen] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const handleDelete = async () => {
        const result = await removeAllowance(allowanceIds);
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
                <Button variant={"destructive"}>
                    <Trash className="h-4 w-4" />
                </Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will delete the allowance and all its data.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleDelete} variant={"destructive"}>Delete</Button>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
    );
}