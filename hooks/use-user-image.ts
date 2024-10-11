import { useState, useEffect } from 'react'
import { fetchUserImage } from '@/data/fetch-user-image'

interface UserImageResponse {
    image?: string
    error?: string
}

export function useUserImage() {
    const [userImage, setUserImage] = useState<string | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        async function getUserImage() {
            try {
                setIsLoading(true)
                const response = await fetchUserImage()

                if (response.error) {
                    setError(response.error)
                } else if (response.image) {
                    setUserImage(response.image)
                } else {
                    setError("Image not found")
                }
            } catch (err) {
                setError("An error has occurred while fetching the user image")
            } finally {
                setIsLoading(false)
            }
        }

        getUserImage()
    }, [])

    return { userImage, isLoading, error }
}