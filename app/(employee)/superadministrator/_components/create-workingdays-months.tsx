"use client"

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from "@/components/ui/button"
import { FaSpinner, FaCheckCircle, FaPlay } from 'react-icons/fa'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

import { toast } from '@/hooks/use-toast'

import { generateWorkingMonthsAndDays, checkWorkingDaysExist } from '@/actions/superadmin/generate-working-days-and-months'
import { cn } from '@/lib/utils'
import { Check, Play } from 'lucide-react'

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

        <Button
            onClick={handleGenerateWorkingDays}
            disabled={isGenerating || workingDaysExist}
            variant={"superadmin"}
            className="h-auto w-full py-4 flex flex-col items-center justify-center"
        >
            {isGenerating ? (
                <>
                    <FaSpinner className="mb-2 h-6 w-6 animate-spin" />
                    Generating...
                </>
            ) : workingDaysExist ? (
                <>
                    <Check className="w-6 h-6 mb-2" />
                    Already Generated For this Year
                </>
            ) : (
                <>
                    <Play className="w-6 h-6 mb-2" />
                    Generate Working Months and Days
                </>
            )}
        </Button>
    )
}