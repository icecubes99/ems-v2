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

interface AlertDialogDemoProps {
    assignedUseId: string;
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

export function RemoveUserDialog({ assignedUseId, variant }: AlertDialogDemoProps) {
    const [assignedUserId, setAssignedUserId] = useState(assignedUseId); // Replace with actual user ID

    const [open, setOpen] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const handleRemoveUser = async () => {
        const result = await removeAssignedUser(assignedUserId);
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
                <Button variant={variant}>Remove User</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will remove the user from this Designation Permanently.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <Button onClick={handleRemoveUser} variant={"superadmin"}>Remove User</Button>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
    );
}