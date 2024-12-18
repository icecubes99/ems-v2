'use client'

import React, { useState, useEffect } from 'react'
import { Clock } from 'lucide-react'
import { cn } from '@/lib/utils'
import { ThemeToggle } from './theme-toggle'

interface SidebarEnhancementsProps {
    isCollapsed: boolean
    userTimeZone: string
    className?: string
}

const quotes = [
    { text: "Stay hungry, stay foolish.", author: "Steve Jobs" },
    { text: "Success is not final.", author: "Winston Churchill" },
    { text: "Keep moving forward.", author: "Walt Disney" },
    { text: "Dream big.", author: "Shan Tranquilan" },
    { text: "Seize the day.", author: "Horace" },
    { text: "You can do it.", author: "Reanne" },
    { text: "Never give up.", author: "Marlo" },
    { text: "Stay positive.", author: "Paul" },
    { text: "Be yourself.", author: "Kyle" },
    { text: "Believe in yourself.", author: "Kyle Table" },
    { text: "Stay focused.", author: "Ellyanna" },
    { text: "Work hard, play hard.", author: "Miguel " },
    { text: "Keep it simple.", author: "Brian " },
    { text: "Stay humble.", author: "Jose " },
    { text: "Be kind.", author: "Kanye West" },
    { text: "Think different.", author: "Apple" },
    { text: "Impossible is nothing.", author: "Adidas" },
    { text: "Have it your way.", author: "Burger King" },
    { text: "Think big.", author: "Emmanuel Aguado" },
    { text: "Stay curious.", author: "Stephen Hawking" },
    { text: "Be the change.", author: "Mahatma Gandhi" },
    { text: "Carpe diem.", author: "Unknown" },
    { text: "Keep calm.", author: "Unknown" },
    { text: "Teamwork works.", author: "John C. Maxwell" },
    { text: "Hard work.", author: "Kevin Durant" },
    { text: "Success is habit.", author: "Aristotle" },
    { text: "Love your work.", author: "Steve Jobs" },
    { text: "Keep going.", author: "Sam Levenson" },
    { text: "Future is now.", author: "Mahatma Gandhi" },
    { text: "Fill your life.", author: "Steve Jobs" },
    { text: "Love your job.", author: "Confucius" },
    { text: "Work in silence.", author: "Frank Ocean" },
    { text: "Work hard.", author: "Unknown" },
    { text: "Happiness is success.", author: "Albert Schweitzer" },
    { text: "Dream big.", author: "Emmanuel Aguado" }
]

export default function SidebarEnhancements({
    isCollapsed,
    userTimeZone,
    className
}: SidebarEnhancementsProps) {
    const [currentTime, setCurrentTime] = useState(new Date())
    const [isVisible, setIsVisible] = useState(false)
    const [quote, setQuote] = useState({ text: '', author: '' })
    const [showQuote, setShowQuote] = useState(false)
    const [showDate, setShowDate] = useState(false)
    const [showClock, setShowClock] = useState(false)

    useEffect(() => {
        const intervalId = setInterval(() => {
            setCurrentTime(new Date())
        }, 1000)

        return () => clearInterval(intervalId)
    }, [])

    useEffect(() => {
        let timeoutId: NodeJS.Timeout

        if (!isCollapsed) {
            timeoutId = setTimeout(() => {
                setIsVisible(true)
            }, 2000)
        } else {
            setIsVisible(false)
        }

        return () => {
            if (timeoutId) clearTimeout(timeoutId)
        }
    }, [isCollapsed])

    useEffect(() => {
        const randomQuote = quotes[Math.floor(Math.random() * quotes.length)]
        setQuote(randomQuote)
    }, [])

    useEffect(() => {
        const checkHeight = () => {
            setShowQuote(window.innerHeight > 925)
            setShowDate(window.innerHeight > 825)
            setShowClock(window.innerHeight > 780)
        }

        checkHeight()
        window.addEventListener('resize', checkHeight)

        return () => {
            window.removeEventListener('resize', checkHeight)
        }
    }, [])

    if (isCollapsed) return null

    return (
        <div
            className={cn(
                'px-4 space-y-4 items-center transition-all duration-1000 ease-in-out flex flex-col justify-center',
                isVisible ? 'opacity-50' : 'opacity-0',
                className
            )}
        >
            {/* Clock widget */}
            {showClock && (
                <div className="flex items-center space-x-2 justify-center w-full">
                    <ThemeToggle />
                    <Clock className="h-5 w-5 text-purple-700 dark:text-purple-50" />
                    <div>
                        <p className="text-sm font-medium dark:text-gray-50">
                            {currentTime.toLocaleTimeString('en-US', {
                                timeZone: userTimeZone,
                                hour: '2-digit',
                                minute: '2-digit',
                                second: '2-digit'
                            })}
                        </p>
                        <p className="text-xs text-purple-800 dark:text-purple-200">{userTimeZone}</p>
                    </div>
                </div>
            )}

            {/* Date widget */}
            {showDate && (
                <div className="text-center">
                    <p className="text-xs font-medium dark:text-gray-50">
                        {currentTime.toLocaleDateString('en-US', {
                            timeZone: userTimeZone,
                            weekday: 'long',
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric'
                        })}
                    </p>
                </div>
            )}

            {/* Motivational quote */}
            {showQuote && (
                <div className="text-center">
                    <p className="text-sm italic dark:text-gray-50">"{quote.text}"</p>
                    <p className="text-xs text-purple-800 mt-1 dark:text-purple-200">- {quote.author}</p>
                </div>
            )}


        </div>
    )
}