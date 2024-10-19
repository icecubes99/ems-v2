'use client'

import { useState } from 'react'
import { Button } from "@/components/ui/button"
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"
import { generatePayroll } from '@/actions/superadmin/generate-payroll'
import { DollarSign, Loader2 } from 'lucide-react'
import { cn } from '@/lib/utils'
import { FormError } from '@/components/form-error'
import { FormSucess } from '@/components/form-sucess'
import { toast } from 'sonner'

export default function GeneratePayroll({ className }: { className?: string }) {
    const [isLoading, setIsLoading] = useState(false)
    const [result, setResult] = useState<{ success?: string; error?: string } | null>(null)

    const [error, setError] = useState<string | undefined>("");
    const [success, setSuccess] = useState<string | undefined>("");


    const handleGeneratePayroll = async () => {
        setIsLoading(true)
        setResult(null)

        setError("");
        setSuccess("");

        const result = await generatePayroll();
        if (result.error) {
            console.error(result.error);
            setIsLoading(false)
            toast.error(result.error)
        } else {
            console.log(result.success);
            toast.success(result.success)
            setIsLoading(false)
            setTimeout(() => {
                window.location.reload();
            }, 500);
        }
    }

    return (
        <Button
            onClick={handleGeneratePayroll}
            disabled={isLoading}
            className="h-auto w-full py-4 flex flex-col items-center justify-center"
            variant={"superadmin"}

        >
            <>

                {isLoading ? (
                    <>
                        <Loader2 className="mb-2 h-6 w-6 animate-spin" />
                        Generating Payroll...
                    </>
                ) : (
                    <>

                        <DollarSign className="w-6 h-6 mb-2" />
                        Generate Payroll
                    </>
                )}
            </>
        </Button>
    )
}