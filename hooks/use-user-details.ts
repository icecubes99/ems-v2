import { useState, useEffect } from 'react'
import { fetchUserDetails, fetchUserImage } from '@/data/fetch-user-details'
import { User } from '@prisma/client'


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

export function useUserDetails(userId: string) {
    const [user, setUser] = useState<User | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getUserDetails = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchUserDetails(userId)

                if (result.error) {
                    setError(result.error)
                    setUser(null)
                } else {
                    setUser(result.user as User)
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching user details:', error)
                setUser(null)
            } finally {
                setIsLoading(false)
            }
        }

        getUserDetails()
    }, [userId])

    return { user, isLoading, error }
}