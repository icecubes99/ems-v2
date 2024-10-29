"use client"

import { useState, useEffect } from "react"
import { getActiveAllowances, getInactiveAllowances } from "@/data/fetch-allowances"
import { Allowance } from "@prisma/client"

export function useActiveAllowances() {
    const [allowances, setAllowances] = useState<Allowance[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchAllowances = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await getActiveAllowances()

                if (result.error) {
                    setError(result.error)
                    setAllowances(null)
                } else {
                    setAllowances(result.allowances as Allowance[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching allowances:', error)
                setAllowances(null);
            } finally {
                setIsLoading(false)
            }
        }

        fetchAllowances()
    }, [])

    return { allowances, isLoading, error }
}

export function useInactiveAllowances() {
    const [allowances, setAllowances] = useState<Allowance[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchAllowances = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await getInactiveAllowances()

                if (result.error) {
                    setError(result.error)
                    setAllowances(null)
                } else {
                    setAllowances(result.allowances as Allowance[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching allowances:', error)
                setAllowances(null);
            } finally {
                setIsLoading(false)
            }
        }

        fetchAllowances()
    }, [])

    return { allowances, isLoading, error }
}