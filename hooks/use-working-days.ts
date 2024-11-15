"use client"

import { useState, useEffect } from 'react'
import { fetchWorkingDays, fetchWorkingDay } from '@/data/fetch-working-days'
import { WorkingDay } from '@prisma/client'

export function useWorkingDays(startDate: Date, endDate: Date) {
    const [workingDays, setWorkingDays] = useState<WorkingDay[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getWorkingDays = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchWorkingDays(startDate, endDate)

                if (result.error) {
                    setError(result.error)
                    setWorkingDays(null)
                } else {
                    setWorkingDays(result.workingDays ?? null)
                }
            } catch (error) {
                setError("An error occurred while fetching data")
                console.error("Error fetching Working Days:", error)
                setWorkingDays(null)
            } finally {
                setIsLoading(false)
            }
        }

        getWorkingDays()
    }, [startDate, endDate])

    return { workingDays, isLoading, error }
}

export function useWorkingDay(workingDayId: string) {
    const [workingDay, setWorkingDay] = useState<WorkingDay | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getWorkingDay = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchWorkingDay(workingDayId)

                if (result.error) {
                    setError(result.error)
                    setWorkingDay(null)
                } else {
                    setWorkingDay(result.workingDay ?? null)
                }
            } catch (error) {
                setError("An error occurred while fetching data")
                console.error("Error fetching Working Day:", error)
                setWorkingDay(null)
            } finally {
                setIsLoading(false)
            }
        }

        getWorkingDay()
    }, [workingDayId])

    return { workingDay, isLoading, error }
}