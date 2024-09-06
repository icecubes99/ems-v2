// hooks/use-holidays.ts
"use client"

import { useState, useEffect, useCallback } from 'react'
import { getHolidays } from '@/data/fetch-holidays'
import { Holiday } from '@prisma/client'
import { set } from 'date-fns'


export function useHolidays() {
    const [holidays, setHolidays] = useState<Holiday[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)


    useEffect(() => {
        const fetchHolidays = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await getHolidays()

                if (result.error) {
                    setError(result.error)
                    setHolidays(null)
                } else {
                    setHolidays(result.holidays as Holiday[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching holidays:', error)
                setHolidays(null);
            } finally {
                setIsLoading(false)
            }
        }

        fetchHolidays()
    }, [])


    return { holidays, isLoading, error }
}