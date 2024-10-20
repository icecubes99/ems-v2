'use server'

import { put } from '@vercel/blob'
import { revalidatePath } from 'next/cache'
import { prisma } from '@/lib/prisma'

export async function uploadDocument(formData: FormData) {
    const file = formData.get('file') as File
    const userId = formData.get('userId') as string
    const documentName = formData.get('documentName') as string
    const documentType = formData.get('documentType') as string

    if (!file) {
        return { error: 'No file provided' }
    }

    try {
        const blob = await put(`documents/${userId}-${file.name}`, file, {
            access: 'public',
        })

        // Create a new document record in the database
        const document = await prisma.documents.create({
            data: {
                documentName,
                documentType,
                documentLink: blob.url,
                userId,
            },
        })

        revalidatePath('/documents') // Adjust this path as needed

        return { documentLink: blob.url }
    } catch (error) {
        console.error('Error uploading document:', error)
        return { error: 'Failed to upload document' }
    }
}