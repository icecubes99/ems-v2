import { useState, useEffect } from 'react'
import { getSpecificUserDesignationHead } from '@/actions/getSpecificUser'
import { Designation } from '@prisma/client'

export function useUserDesignationHead(userId: string) {
    const [designationId, setDesignationId] = useState<Designation | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        async function fetchDesignationHead() {
            try {
                setIsLoading(true)
                const result = await getSpecificUserDesignationHead(userId)
                if ('error' in result) {
                    setError(result.error as string)
                } else if (result.success && result.data.designation) {
                    setDesignationId(result.data.designation)
                } else {
                    setError('Designation not found')
                }
            } catch (err) {
                setError('An error occurred while fetching the designation')
            } finally {
                setIsLoading(false)
            }
        }

        fetchDesignationHead()
    }, [userId])

    return { designationId, isLoading, error }
}