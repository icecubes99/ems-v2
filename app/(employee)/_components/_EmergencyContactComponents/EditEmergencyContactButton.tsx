"use client"

import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import EditEmergencyContactForm from "./EditEmergencyContactForm";

const EditEmergencyContactButton = () => {

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"auth"}>
                    Edit Emergency Contact
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <EditEmergencyContactForm />
            </DialogContent>
        </Dialog>
    )
}
export default EditEmergencyContactButton;