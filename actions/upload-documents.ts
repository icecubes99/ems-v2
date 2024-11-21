'use server'

import { put, } from '@vercel/blob'
import { prisma } from '@/lib/prisma'
import { checkIsArchived } from './checkIsArchived'

export async function uploadDocument(formData: FormData) {
    const file = formData.get('file') as File
    const userId = formData.get('userId') as string
    const documentName = formData.get('documentName') as string
    const documentType = formData.get('documentType') as string

    if (!file) {
        return { error: 'No file provided' }
    }

    const isArchived = await checkIsArchived(userId);
    if (isArchived.error) {
        return { error: isArchived.error };
    }

    try {
        const blob = await put(`documents/${userId}-${file.name}`, file, {
            access: 'public',

        })

        const document = await prisma.documents.create({
            data: {
                documentName,
                documentType,
                documentLink: blob.url,
                userId,
            },
        })

        return { documentLink: blob.url }
    } catch (error) {
        console.error('Error uploading document:', error)
        return { error: 'Failed to upload document' }
    }
}