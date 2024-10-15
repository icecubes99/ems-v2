"use client"

import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

import CreateDesignationForm from "./CreateDesignationForm";

interface CreateDesignationProps {
    variant: "default" | "destructive" | "outline" | "secondary" | "auth" | "admin" | "superadmin" | "ghost" | "link" | "sidebar" | null | undefined;
}

const CreateDesignationButton = ({ variant }: CreateDesignationProps) => {
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button className="w-72" variant={variant}>
                    Create Designation
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <CreateDesignationForm variant={variant} />
            </DialogContent>
        </Dialog>
    )
}

export default CreateDesignationButton;