'use client'

import { useState, useEffect } from 'react'
import { useTheme } from 'next-themes'
import { Switch } from '@/components/ui/switch'
import { Moon, Sun } from 'lucide-react'

export function ThemeToggle() {
    const [mounted, setMounted] = useState(false)
    const { theme, setTheme } = useTheme()

    useEffect(() => {
        setMounted(true)

        const handleKeyDown = (event: KeyboardEvent) => {
            // Check for Cmd+Shift+D (Mac) or Ctrl+Shift+D (Windows/Linux)
            if (event.metaKey && event.key === 'd') {
                event.preventDefault()
                setTheme(theme === 'dark' ? 'light' : 'dark')
            }
        }

        window.addEventListener('keydown', handleKeyDown)

        // Cleanup function to remove the event listener
        return () => {
            window.removeEventListener('keydown', handleKeyDown)
        }
    }, [theme, setTheme])

    if (!mounted) {
        return null
    }

    return (
        <div className="flex items-center space-x-2 mr-6">
            <Sun className="h-4 w-4" />
            <Switch
                checked={theme === 'dark'}
                onCheckedChange={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
                aria-label="Toggle dark mode"
            />
            <Moon className="h-4 w-4" />
        </div>
    )
}