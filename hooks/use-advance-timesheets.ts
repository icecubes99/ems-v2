"use client"

import { useState, useEffect } from 'react'
import { fetchAdvanceTimesheets } from '@/data/fetch-advance-timesheets'
import { AdvanceTimesheet } from '@/types/types'

export function useAdvanceTimesheets() {
    const [advanceTimesheets, setAdvanceTimesheets] = useState<AdvanceTimesheet[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getAdvanceTimesheets = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchAdvanceTimesheets()

                if (result.error) {
                    setError(result.error)
                    setAdvanceTimesheets(null)
                } else {
                    setAdvanceTimesheets(result.advanceTimesheets as AdvanceTimesheet[])
                }

            } catch (error) {
                setError("An error occured while fetching data")
                console.error("Error fetching Advance Timesheets", error)
                setAdvanceTimesheets(null)
            } finally {
                setIsLoading(false)
            }
        }

        getAdvanceTimesheets()
    }, [])

    return { advanceTimesheets, isLoading, error }
}