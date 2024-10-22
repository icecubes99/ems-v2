"use client"
import { fetchAllDocuments, fetchSingleDocument, fetchUserDocuments } from "@/data/fetch-documents"
import { Documents } from "@prisma/client";
import { useEffect, useState } from "react";

export function useAllDocuments() {
    const [documents, setDocuments] = useState<Documents[] | null>(null)
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getDocuments = async () => {
            setLoading(true)
            setError(null)

            try {
                const result = await fetchAllDocuments()
                if (result.error) {
                    setError(result.error)
                    setDocuments(null)
                } else {
                    setDocuments(result.documents as Documents[])
                }
            } catch (error) {
                setError("An error occured while fetching data")
                console.error("Error fetching Documents", error)
                setDocuments(null)
            } finally {
                setLoading(false)
            }
        }

        getDocuments()
    }, [])

    return { documents, loading, error }
}

export function useUserDocuments(userId: string) {
    const [documents, setDocuments] = useState<Documents[] | null>(null)
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getUserDocuments = async () => {
            setLoading(true)
            setError(null)

            try {
                const result = await fetchUserDocuments(userId)

                if (result.error) {
                    setError(result.error)
                    setDocuments(null)
                } else {
                    setDocuments(result.userDocuments as Documents[])
                }
            } catch (error) {
                setError("An error occured while fetching data")
                console.error("Error fetching User Documents", error)
                setDocuments(null)
            } finally {
                setLoading(false)
            }
        }

        getUserDocuments()
    }, [userId])

    return { documents, loading, error }
}

export function useSingleDocument(documentId: string) {
    const [document, setDocument] = useState<Documents | null>(null)
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getDocument = async () => {
            setLoading(true)
            setError(null)

            try {
                const result = await fetchSingleDocument(documentId)

                if (result.error) {
                    setError(result.error)
                    setDocument(null)
                } else {
                    setDocument(result.document as Documents)
                }
            } catch (error) {
                setError("An error occured while fetching data")
                console.error("Error fetching User Documents", error)
                setDocument(null)
            } finally {
                setLoading(false)
            }
        }

        getDocument()
    }, [documentId])

    return { document, loading, error }
}