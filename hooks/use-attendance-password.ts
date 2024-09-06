"use client"

import { useState, useEffect, useCallback } from 'react'
import { getAttendancePasswords } from '@/data/fetch-passwords'
import { WorkingDay } from '@prisma/client'

export function useAttendancePasswords() {
    const [days, setDays] = useState<WorkingDay[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchPasswords = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await getAttendancePasswords()

                if (result.error) {
                    setError(result.error)
                    setDays(null)
                } else {
                    setDays(result.days as WorkingDay[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching passwords:', error)
                setDays(null);
            } finally {
                setIsLoading(false)
            }
        }

        fetchPasswords()
    }, [])

    return { days, isLoading, error }
}