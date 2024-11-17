// hooks/use-salary-history.ts
"use client"

import { useState, useEffect } from 'react'
import { fetchUserSalaryHistory } from '@/data/fetch-salary'
import { SalaryHistory, UserSalary } from '@prisma/client'


interface SalaryHistoryWithUser {
    id: string;
    userId: string;
    basicSalary: number;
    grossSalary: number;
    startDate: Date;
    endDate: Date;
    amountIncreased: number | null;
    salaryIncreaseEventId: string | null;
    createdAt: Date;
    updatedAt: Date;
    user: {
        firstName: string | null;
        lastName: string | null;
    };
}
export function useSalaryHistory(userId: string) {
    const [salaryHistories, setSalaryHistories] = useState<SalaryHistoryWithUser[] | null>(null)
    const [currentSalary, setCurrentSalary] = useState<Pick<UserSalary, 'basicSalary' | 'grossSalary'> | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchHistory = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchUserSalaryHistory(userId)
                if (result.error) {
                    setError(result.error)
                    setSalaryHistories(null)
                    setCurrentSalary(null)
                } else {
                    setSalaryHistories(result.salaryHistories ?? null)
                    setCurrentSalary(result.currentSalary || null)
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                setSalaryHistories(null)
                setCurrentSalary(null)
            } finally {
                setIsLoading(false)
            }
        }

        fetchHistory()
    }, [userId])

    return { salaryHistories, currentSalary, isLoading, error }
}