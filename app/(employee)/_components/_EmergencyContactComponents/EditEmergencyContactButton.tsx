"use client"

import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import EditEmergencyContactForm from "./EditEmergencyContactForm";
import { User } from "lucide-react";

interface Props {
    userId: string;
}

const EditEmergencyContactButton = ({ userId }: Props) => {

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant="outline" className="mt-2 w-full">
                    <User className="mr-2 h-4 w-4" />
                    Edit Emergency Contact
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <EditEmergencyContactForm userId={userId} />
            </DialogContent>
        </Dialog>
    )
}
export default EditEmergencyContactButton;