// hooks/use-holidays.ts
"use client"

import { useState, useEffect, useCallback } from 'react'
import { getHolidays, getSpecificHoliday } from '@/data/fetch-holidays'
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

export function useSpecificHoliday(holidayId: string) {
    const [holiday, setHoliday] = useState<Holiday | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchHoliday = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await getSpecificHoliday(holidayId)

                if (result.error) {
                    setError(result.error)
                    setHoliday(null)
                } else {
                    setHoliday(result.holiday as Holiday)
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching holiday:', error)
                setHoliday(null);
            } finally {
                setIsLoading(false)
            }
        }

        fetchHoliday()
    }, [holidayId])

    return { holiday, isLoading, error }
}