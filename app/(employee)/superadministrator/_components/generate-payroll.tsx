'use client'

import { useState } from 'react'
import { Button } from "@/components/ui/button"
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"
import { generatePayroll } from '@/actions/superadmin/generate-payroll'
import { Loader2 } from 'lucide-react'
import { cn } from '@/lib/utils'
import { FormError } from '@/components/form-error'
import { FormSucess } from '@/components/form-sucess'

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
            setError(result.error);
            setIsLoading(false)
        } else {
            console.log(result.success);
            setSuccess(result.success);
            setIsLoading(false)
        }
    }

    return (
        <div className={cn("max-w-md mx-auto mt-10 p-6 bg-white rounded-lg shadow-md", className)}>
            <h1 className="text-2xl font-bold mb-6 text-center">Payroll Generator</h1>
            <Button
                onClick={handleGeneratePayroll}
                disabled={isLoading}
                className="w-full"
                variant={"superadmin"}
            >
                {isLoading ? (
                    <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Generating Payroll...
                    </>
                ) : (
                    'Generate Payroll'
                )}
            </Button>
            <div className='mt-4'>
                <FormError message={error} />
                <FormSucess message={success} />
            </div>
        </div>
    )
}