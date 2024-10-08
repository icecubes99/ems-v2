"use client"
import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import EmergencyContactForm from "./EmergencyContactForm";

const AddEmergencyContactButton = () => {
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"auth"}>
                    Add Emergency Contact
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <EmergencyContactForm />
            </DialogContent>
        </Dialog>
    )

}

export default AddEmergencyContactButton;