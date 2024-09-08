"use client"

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

import { toast } from '@/hooks/use-toast'

import { generateWorkingMonthsAndDays, checkWorkingDaysExist } from '@/actions/superadmin/generate-working-days-and-months'
import { cn } from '@/lib/utils'

export default function WorkingDaysManager({ classname }: { classname: string }) {
    const [isGenerating, setIsGenerating] = useState(false)
    const [workingDaysExist, setWorkingDaysExist] = useState(false)
    const router = useRouter()

    useEffect(() => {
        checkWorkingDaysExist().then(setWorkingDaysExist)
    }, [])

    const handleGenerateWorkingDays = async () => {
        if (workingDaysExist) {
            toast({
                title: "Warning",
                description: "Working days have already been generated for this year.",
                variant: "destructive",
            })
            return
        }

        setIsGenerating(true)
        try {
            await generateWorkingMonthsAndDays()
            toast({
                title: "Success",
                description: "Working months and days have been generated for the rest of the year.",
            })
            setWorkingDaysExist(true)
            router.refresh()
        } catch (error) {
            toast({
                title: "Error",
                description: "Failed to generate working days. Please try again.",
                variant: "destructive",
            })
        } finally {
            setIsGenerating(false)
        }
    }

    return (
        <div className={cn("space-y-6", classname)}>
            <Card>
                <CardHeader>
                    <CardTitle>Generate Working Days</CardTitle>
                    <CardDescription>
                        Generate working months and days for the rest of the year.
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <Button
                        onClick={handleGenerateWorkingDays}
                        disabled={isGenerating || workingDaysExist}
                        variant={"superadmin"}
                        className='w-full'
                    >
                        {isGenerating ? "Generating..." : workingDaysExist ? "Already Generated For this Year" : "Generate Working Months and Days"}
                    </Button>
                </CardContent>
            </Card>
        </div>
    )
}