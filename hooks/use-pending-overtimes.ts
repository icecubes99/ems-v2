"use client"

import { useState, useEffect } from 'react'
import { OvertimesWithUser } from '@/types/types'
import { fetchPendingOvertimes } from '@/data/fetch-pending-overtimes'
import { Overtimes, User, LeaveStatus, OvertimeType, Gender } from '@prisma/client'

export function usePendingOvertimes() {
    const [overtimes, setOvertimes] = useState<OvertimesWithUser[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchOvertimes = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchPendingOvertimes()

                if (result.error) {
                    setError(result.error)
                    setOvertimes(null)
                } else {
                    setOvertimes(result.overtime as OvertimesWithUser[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching overtimes:', error)
                setOvertimes(null)
            } finally {
                setIsLoading(false)
            }
        }

        fetchOvertimes()
    }, [])

    return { overtimes, isLoading, error }
}
