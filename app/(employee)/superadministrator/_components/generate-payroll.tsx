'use client'

import { useState } from 'react'
import { Button } from "@/components/ui/button"
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"
import { generatePayroll } from '@/actions/superadmin/generate-payroll'
import { Loader2 } from 'lucide-react'
import { cn } from '@/lib/utils'

export default function GeneratePayroll({ className }: { className?: string }) {
    const [isLoading, setIsLoading] = useState(false)
    const [result, setResult] = useState<{ success?: string; error?: string } | null>(null)

    const handleGeneratePayroll = async () => {
        setIsLoading(true)
        setResult(null)
        try {
            const response = await generatePayroll()
            setResult(response)
        } catch (error) {
            setResult({ error: 'An unexpected error occurred' })
        } finally {
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
            {result && (
                <Alert className="mt-4" variant={result.success ? "default" : "destructive"}>
                    <AlertTitle>{result.success ? "Success" : "Error"}</AlertTitle>
                    <AlertDescription>
                        {result.success || result.error}
                    </AlertDescription>
                </Alert>
            )}
        </div>
    )
}