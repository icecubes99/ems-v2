"use client";

import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

import UpdateDepartmentForm from './UpdateDepartmentForm';

interface UpdateDepartmentButtonProps {
    departmentId: string;
}
const UpdateDepartmentButton = ({ departmentId }: UpdateDepartmentButtonProps) => {
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"superadmin"}>
                    Update Department
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <UpdateDepartmentForm departmentId={departmentId} />
            </DialogContent>
        </Dialog>
    )
}
export default UpdateDepartmentButton;