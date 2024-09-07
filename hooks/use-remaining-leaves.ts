"use client"

import { useState, useEffect, useCallback } from 'react'
import { fetchPendingLeaves } from '@/data/fetch-pending-leaves';
import { Leaves } from '@prisma/client'
import { fetchRemainingLeaves } from '@/data/fetch-remaining-leaves';
import { LeavesWithUser } from '@/types/types';

export function useRemainingLeaves() {
    const [leaves, setLeaves] = useState<LeavesWithUser[] | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchLeaves = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchRemainingLeaves();

                if (result.error) {
                    setError(result.error);
                    setLeaves(null);
                } else {
                    setLeaves(result.leaves as LeavesWithUser[]);
                }

            } catch (error) {
                setError('An error occurred while fetching data');
                console.error('Error fetching leaves:', error);
                setLeaves(null);
            } finally {
                setIsLoading(false);
            }
        }

        fetchLeaves();
    }, []);

    return { leaves, isLoading, error };
}