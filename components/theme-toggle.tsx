'use client'

import { useState, useEffect } from 'react'
import { useTheme } from 'next-themes'
import { Switch } from '@/components/ui/switch'
import { Moon, Sun } from 'lucide-react'
import {
    Tooltip,
    TooltipContent,
    TooltipProvider,
    TooltipTrigger,
} from "@/components/ui/tooltip"


export function ThemeToggle() {
    const [mounted, setMounted] = useState(false)
    const { theme, setTheme } = useTheme()

    useEffect(() => {
        setMounted(true)

        const handleKeyDown = (event: KeyboardEvent) => {
            if (event.metaKey && event.key === 'h') {
                event.preventDefault()
                setTheme(theme === 'dark' ? 'light' : 'dark')
            }
        }

        window.addEventListener('keydown', handleKeyDown)

        return () => {
            window.removeEventListener('keydown', handleKeyDown)
        }
    }, [theme, setTheme])

    if (!mounted) {
        return null
    }

    return (

        <div className="flex items-center space-x-2 mr-3">
            <Sun className="h-4 w-4" />
            <TooltipProvider>
                <Tooltip>
                    <TooltipTrigger>
                        <Switch
                            checked={theme === 'dark'}
                            onCheckedChange={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
                            aria-label="Toggle dark mode"
                        />
                    </TooltipTrigger>
                    <TooltipContent className='duration-[2000ms]'>
                        <div>
                            <p><kbd>Cmd + D</kbd></p>
                        </div>
                    </TooltipContent>
                </Tooltip>
            </TooltipProvider>
            <Moon className="h-4 w-4" />
        </div>
    )
}