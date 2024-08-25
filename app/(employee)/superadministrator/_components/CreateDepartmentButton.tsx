"use client"

import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

import CreateDepartmentForm from './CreateDepartmentForm';

const CreateDepartmentButton = () => {
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"superadmin"}>
                    Create Department
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <CreateDepartmentForm />
            </DialogContent>
        </Dialog>
    )

}
export default CreateDepartmentButton;
