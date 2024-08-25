"use client";
import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import EditAddressForm from "@/app/(employee)/_components/_AddressComponents/EditAddressForm";


const EditAddressButton = () => {

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button variant={"auth"}>
                    Edit Address
                </Button>
            </DialogTrigger>
            <DialogContent className="p-0 w-auto bg-transparent border-none">
                <EditAddressForm />
            </DialogContent>
        </Dialog>
    )
}
export default EditAddressButton