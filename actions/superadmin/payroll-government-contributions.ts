'use server'

import { prisma } from '@/lib/prisma'

interface Contribution {
    id: string
    type: string
    brackets: any
    createdAt: Date
    updatedAt: Date
}

interface ContributionResult {
    success: boolean
    data?: Contribution | Contribution[]
    error?: string
}

export async function updateGovernmentContribution(type: string, brackets: any): Promise<ContributionResult> {
    try {
        const updatedContribution = await prisma.governmentContribution.upsert({
            where: { type },
            update: { brackets },
            create: { type, brackets },
        })
        return { success: true, data: updatedContribution }
    } catch (error) {
        console.error('Error updating government contribution:', error)
        return { success: false, error: 'Failed to update government contribution' }
    }
}

export async function getGovernmentContributions(): Promise<ContributionResult> {
    try {
        const contributions = await prisma.governmentContribution.findMany()
        return { success: true, data: contributions }
    } catch (error) {
        console.error('Error fetching government contributions:', error)
        return { success: false, error: 'Failed to fetch government contributions' }
    }
}