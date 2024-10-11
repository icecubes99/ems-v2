'use client'

import { useState, useRef, useEffect } from 'react'
import { useFormStatus } from 'react-dom'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Upload, Loader2 } from 'lucide-react'
import { uploadProfilePicture } from '@/actions/upload-profile-pic'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { DialogTitle } from '@radix-ui/react-dialog'
import { FaUser } from 'react-icons/fa'

export default function UploadProfilePicture({ userId, initialProfilePicture }: { userId: string, initialProfilePicture?: string }) {
    const [preview, setPreview] = useState<string | null>(initialProfilePicture || null);
    const [error, setError] = useState<string | null>(null);


    const [open, setOpen] = useState(false);
    const [isMounted, setIsMounted] = useState(false);

    const handleOpenChange = (newOpen: boolean) => {
        setOpen(newOpen);
        if (!newOpen) {
            window.location.reload();
        }
    }

    const formRef = useRef<HTMLFormElement>(null);

    const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (file) {
            const reader = new FileReader();
            reader.onloadend = () => {
                setPreview(reader.result as string);
            };
            reader.readAsDataURL(file);
        }
    };

    async function handleSubmit(formData: FormData) {
        formData.append('userId', userId.toString());
        const result = await uploadProfilePicture(formData);
        if (result.error) {
            setError(result.error);
        } else {
            setPreview(result.url as string);
            formRef.current?.reset();
            setError(null);
            handleOpenChange(false);
        }
    }

    useEffect(() => {
        setIsMounted(true);
    }, []);

    return (
        <Dialog open={open} onOpenChange={setOpen}>

            {isMounted && (
                <DialogTrigger>
                    <Button className='w-full' variant={"auth"}>Upload Profile Picture</Button>
                </DialogTrigger>
            )}
            <DialogContent className='max-w-md mx-auto mt-8 p-6 bg-white rounded-lg shadow-md'>
                <DialogTitle>
                    <h2 className="text-2xl font-bold mb-4">Upload Profile Picture</h2>
                </DialogTitle>
                <div className="mb-4 flex justify-center">
                    <Avatar className="w-32 h-32">
                        <AvatarImage src={preview || '/placeholder.svg'} alt="Profile picture" />
                        <AvatarFallback className='bg-neutral-700 text-white'>
                            <FaUser />
                        </AvatarFallback>
                    </Avatar>
                </div>
                <form onSubmit={(e) => { e.preventDefault(); handleSubmit(new FormData(formRef.current!)); }} ref={formRef}>
                    <div className="mb-4">
                        <Label htmlFor="file" className="block text-sm font-medium text-gray-700">
                            Choose a picture
                        </Label>
                        <Input
                            id="file"
                            name="file"
                            type="file"
                            accept="image/*"
                            onChange={handleFileChange}
                            className="mt-1"
                        />
                    </div>
                    <SubmitButton />
                </form>
                {error && (
                    <p className="mt-2 text-red-600">{error}</p>
                )}

            </DialogContent>
        </Dialog>
    );
}

function SubmitButton() {
    const { pending } = useFormStatus()

    return (
        <Button variant={"auth"} type="submit" disabled={pending} className="w-full">
            {pending ? (
                <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Uploading...
                </>
            ) : (
                <>
                    <Upload className="mr-2 h-4 w-4" /> Upload Picture
                </>
            )}
        </Button>
    )
}