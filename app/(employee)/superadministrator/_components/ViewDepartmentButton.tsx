"use client";

import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

import ViewDepartment from "./ViewDepartment";

interface ViewDepartmentButtonProps {
    departmentId: string;
}
const ViewDepartmentButton = ({ departmentId }: ViewDepartmentButtonProps) => {
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"superadmin"}>
                    View Department
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 min-w-[1000px] bg-transparent border-none">
                <ViewDepartment departmentId={departmentId} />
            </DialogContent>
        </Dialog>
    )
}
export default ViewDepartmentButton;