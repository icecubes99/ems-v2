// RemoveTimesheetDialog.tsx
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
import { removeTimesheetFromPayroll } from "@/actions/superadmin/remove/remove-payroll-item-timesheet";
import { Trash } from "lucide-react";
import { useRouter } from "next/navigation";

interface Props {
    timesheetId: string;
}

export function RemovePayrollItemTimesheet({ timesheetId }: Props) {
    const [open, setOpen] = useState(false);
    const [loading, setLoading] = useState(false);
    const router = useRouter();

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    };

    const handleDelete = async () => {
        try {
            setLoading(true);
            const result = await removeTimesheetFromPayroll(timesheetId);

            if (result.error) {
                console.error(result.error);
            } else {
                console.log(result);
                handleOpenChange(false);
            }
        } catch (error) {
            console.error("Failed to remove timesheet:", error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <AlertDialog open={open} onOpenChange={setOpen}>
            <AlertDialogTrigger asChild>
                <Button variant="destructive" size="icon">
                    <Trash className="h-4 w-4" />
                </Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Remove Timesheet</AlertDialogTitle>
                    <AlertDialogDescription>
                        Are you sure you want to remove this timesheet? This action will recalculate the payroll item and cannot be undone.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel disabled={loading}>Cancel</AlertDialogCancel>
                    <Button
                        onClick={handleDelete}
                        variant="destructive"
                        disabled={loading}
                    >
                        {loading ? "Removing..." : "Remove"}
                    </Button>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
    );
}