"use client"
import { useState, useEffect, useCallback } from 'react'
import { fetchRemainingLeaveDays } from '@/data/fetch-remaining-leave-days'
import { User } from '@prisma/client'

interface UseRemainingLeaveDays {
    vacatioDays: number;
    incentiveDays: number;
}

export const useRemainingLeaveDays = () => {
    const [remainingLeaves, setRemainingLeaves] = useState<User | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchRemainingLeaves = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchRemainingLeaveDays();
                if (result.error) {
                    setError(result.error);
                    setRemainingLeaves(null);
                } else {
                    setRemainingLeaves(result as User);
                }

            } catch (error) {
                setError('An error occurred while fetching data');
                console.error('Error fetching leaves:', error);
                setRemainingLeaves(null);
            } finally {
                setIsLoading(false);
            }
        }

        fetchRemainingLeaves();
    }, [])

    return { remainingLeaves, isLoading, error };
}