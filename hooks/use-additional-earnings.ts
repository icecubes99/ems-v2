"use client"

import { useState, useEffect } from 'react'
import { AdditionalEarningsWithUser } from '@/types/types';
import { fetchAdditionalEarnings } from '@/data/fetch-additional-earnings';
import { fetchAdditionalEarning } from '@/data/fetch-additional-earnings';

export function useAdditionalEarnings() {
    const [additionalEarnings, setAdditionalEarnings] = useState<AdditionalEarningsWithUser[] | null>(null);
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getAdditionalEarnings = async () => {
            setIsLoading(true)
            setError(null)
            try {
                const result = await fetchAdditionalEarnings()
                if (result.error) {
                    setError(result.error)
                    setAdditionalEarnings(null)
                } else {
                    setAdditionalEarnings(result.additionalEarnings as AdditionalEarningsWithUser[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching Additional Earnings:', error)
                setAdditionalEarnings(null)
            } finally {
                setIsLoading(false)
            }
        }
        getAdditionalEarnings()
    }, [])
    return { additionalEarnings, isLoading, error }
}

export function useAdditionalEarning(additionalEarningId: string) {
    const [additionalEarning, setAdditionalEarning] = useState<AdditionalEarningsWithUser | null>(null);
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getAdditionalEarning = async () => {
            setIsLoading(true)
            setError(null)
            try {
                const result = await fetchAdditionalEarning(additionalEarningId)
                if (result.error) {
                    setError(result.error)
                    setAdditionalEarning(null)
                } else {
                    setAdditionalEarning(result.additionalEarning as AdditionalEarningsWithUser)
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching Additional Earning:', error)
                setAdditionalEarning(null)
            } finally {
                setIsLoading(false)
            }
        }
        getAdditionalEarning()
    }, [])
    return { additionalEarning, isLoading, error }
}
