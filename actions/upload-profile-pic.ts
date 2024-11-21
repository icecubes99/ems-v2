'use server'

import { put } from '@vercel/blob'
import { revalidatePath } from 'next/cache'
import { prisma } from '@/lib/prisma'
import { checkIsArchived } from './checkIsArchived'

export async function uploadProfilePicture(formData: FormData) {
    const file = formData.get('file') as File
    const userId = formData.get('userId') as string

    if (!file) {
        return { error: 'No file provided' }
    }

    const isArchived = await checkIsArchived(userId);
    if (isArchived.error) {
        return { error: isArchived.error };
    }

    try {
        const blob = await put(`profile-pictures/${userId}-${file.name}`, file, {
            access: 'public',
        })

        // Update the user's profile in the database
        await prisma.user.update({
            where: { id: userId },
            data: { image: blob.url },
        })

        revalidatePath('/homepage') // Adjust this path as needed

        return { url: blob.url }
    } catch (error) {
        console.error('Error uploading file:', error)
        return { error: 'Failed to upload file' }
    }
}