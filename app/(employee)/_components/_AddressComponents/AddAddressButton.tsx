"use client";


import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import AddressForm from "@/app/(employee)/_components/_AddressComponents/AddressForm";
import { Button } from "@/components/ui/button";

interface AddAddressButtonProps {

    mode?: "modal" | "redirect";
    asChild?: boolean;
}

const AddAddressButton = () => {

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"auth"}>
                    Add Address Line
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <AddressForm />
            </DialogContent>
        </Dialog>
    )
}
export default AddAddressButton