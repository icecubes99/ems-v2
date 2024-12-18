"use client"

import { useState, useEffect } from 'react'
import { fetchDesignations } from '@/data/fetch-designations'
import { Designation } from '@prisma/client'

export function useSelectDesignations() {
    const [designations, setDesignations] = useState<Designation[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getDesignations = async () => {
            setIsLoading(true)
            setError(null)
            try {
                const result = await fetchDesignations()
                if (result.error) {
                    setError(result.error)
                    setDesignations(null)
                } else {
                    setDesignations(result.designations as Designation[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching Designations:', error)
                setDesignations(null)
            } finally {
                setIsLoading(false)
            }
        }
        getDesignations()
    }, [])

    return { designations, isLoading, error }
}