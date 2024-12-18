import { PrismaClient } from '@prisma/client'
import { NextResponse } from 'next/server'

const prisma = new PrismaClient()

export async function GET() {
    try {
        // Test the connection
        await prisma.$connect()

        // Try to get one user
        const user = await prisma.user.findFirst()

        return NextResponse.json({
            status: 'Connected',
            databaseWorking: true,
            userFound: user ? true : false
        })
    } catch (error) {
        return NextResponse.json({
            status: 'Error',
            message: (error as Error).message
        }, { status: 500 })
    } finally {
        await prisma.$disconnect()
    }
}

