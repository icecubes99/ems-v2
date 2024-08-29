"use client"

import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

import CreateDesignationForm from "./CreateDesignationForm";

const CreateDesignationButton = () => {
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"superadmin"}>
                    Create Designation
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <CreateDesignationForm />
            </DialogContent>
        </Dialog>
    )
}

export default CreateDesignationButton;