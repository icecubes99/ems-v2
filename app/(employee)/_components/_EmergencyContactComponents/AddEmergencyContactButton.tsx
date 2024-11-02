"use client"
import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import EmergencyContactForm from "./EmergencyContactForm";

interface AddEmergencyContactButtonProps {
    userId: string;
}

const AddEmergencyContactButton = ({ userId }: AddEmergencyContactButtonProps) => {
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"auth"}>
                    Add Emergency Contact
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <EmergencyContactForm userId={userId} />
            </DialogContent>
        </Dialog>
    )

}

export default AddEmergencyContactButton;