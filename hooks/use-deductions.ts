"use client"

import { useState, useEffect } from 'react'
import { DeductionsWithUser } from '@/types/types'
import { fetchDeductions } from '@/data/fetch-deductions'
import { fetchDeduction } from '@/data/fetch-deduction';

export function useDeductions() {
    const [deductions, setDeductions] = useState<DeductionsWithUser[] | null>(null);
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getDeductions = async () => {
            setIsLoading(true)
            setError(null)
            try {
                const result = await fetchDeductions()
                if (result.error) {
                    setError(result.error)
                    setDeductions(null)
                } else {
                    setDeductions(result.deductions as DeductionsWithUser[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching Deductions:', error)
                setDeductions(null)
            } finally {
                setIsLoading(false)
            }
        }
        getDeductions()
    }, [])
    return { deductions, isLoading, error }
}

export function useDeduction(deductionId: string) {
    const [deduction, setDeduction] = useState<DeductionsWithUser | null>(null);
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getDeductions = async () => {
            setIsLoading(true)
            setError(null)
            try {
                const result = await fetchDeduction(deductionId)
                if (result.error) {
                    setError(result.error)
                    setDeduction(null)
                } else {
                    setDeduction(result.deduction as DeductionsWithUser)
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching Deductions:', error)
                setDeduction(null)
            } finally {
                setIsLoading(false)
            }
        }
        getDeductions()
    }, [])
    return { deduction, isLoading, error }
}
