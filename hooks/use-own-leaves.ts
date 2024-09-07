"use client"

import { useState, useEffect, useCallback } from 'react'
import { fetchOwnLeaves } from '@/data/fetch-own-leaves'
import { Leaves } from '@prisma/client'

export function useOwnLeaves() {
    const [leaves, setLeaves] = useState<Leaves[] | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchLeaves = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchOwnLeaves();

                if (result.error) {
                    setError(result.error);
                    setLeaves(null);
                } else {
                    setLeaves(result.leaves as Leaves[]);
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