'use client'

import { useAttendancePasswords } from '@/hooks/use-attendance-password'
import React, { useState, useEffect } from 'react'
import { format } from 'date-fns'
import { Home } from 'lucide-react'
import { Button } from '@/components/ui/button'
import Link from 'next/link'

export default function Component() {
    const { days, isLoading, error } = useAttendancePasswords()
    const [currentTime, setCurrentTime] = useState(new Date())

    useEffect(() => {
        const timer = setInterval(() => setCurrentTime(new Date()), 1000)
        return () => clearInterval(timer)
    }, [])

    const today = format(currentTime, 'yyyy-MM-dd')
    const todayPassword = days?.find(day => format(new Date(day.date), 'yyyy-MM-dd') === today)?.password

    if (isLoading) return <FullScreenMessage message="Loading..." />
    if (error) return <FullScreenMessage message={`Error: ${error}`} />

    return (
        <div className="w-screen h-screen bg-purple-900 text-purple-100 flex flex-col items-center justify-center font-sans">
            <div className="text-4xl bg-purple-800 mb-5 px-6 py-4 rounded-lg shadow-lg">
                {todayPassword ? (
                    <div className='flex items-center flex-col text-white/70'>Today's password:
                        <div>
                            <span className="font-bold text-9xl mt-2 flex items-center text-white/100">{todayPassword}</span>
                        </div>
                    </div>
                ) : (
                    "NO PASSWORD FOR TODAY"
                )}
            </div>
            <div className="text-5xl font-bold mb-8">
                {format(currentTime, 'HH:mm:ss')}
            </div>
            <div className="text-4xl mb-12">
                {format(currentTime, 'EEEE, MMMM d, yyyy')}
            </div>
            <div>
                <Link href={"/homepage"}>
                    <Button className="" variant={"ghost"}>
                        <Home className='w-4 h-4' />
                    </Button>
                </Link>
            </div>
        </div>
    )
}

function FullScreenMessage({ message }: { message: string }) {
    return (
        <div className="w-screen h-screen bg-purple-900 text-purple-100 flex items-center justify-center text-2xl">
            {message}
        </div>
    )
}