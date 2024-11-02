"use client"

import { useState, useEffect } from 'react'
import { Archive, ArchiveType } from '@prisma/client'
import { fetchArchives, fetchSingleArchive } from '@/data/fetch-archives'

export function useArchives() {
    const [archives, setArchives] = useState<Archive[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getArchives = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchArchives()

                if (result.error) {
                    setError(result.error)
                    setArchives(null)
                } else {
                    setArchives(result.archives as Archive[])
                }
            } catch (error) {
                setError("An error occurred while fetching data")
                console.error("Error fetching Archives:", error)
                setArchives(null)
            } finally {
                setIsLoading(false)
            }
        }

        getArchives()
    }, [])

    return { archives, isLoading, error }
}

export function useSingleArchive(archiveId: string) {
    const [archive, setArchive] = useState<Archive | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getArchive = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchSingleArchive(archiveId)

                if (result.error) {
                    setError(result.error)
                    setArchive(null)
                } else {
                    setArchive(result.archive as Archive)
                }
            } catch (error) {
                setError("An error occurred while fetching data")
                console.error("Error fetching Archive:", error)
                setArchive(null)
            } finally {
                setIsLoading(false)
            }
        }

        getArchive()
    }, [archiveId])

    return { archive, isLoading, error }
}