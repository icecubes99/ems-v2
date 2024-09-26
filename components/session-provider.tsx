'use client'

import { SessionProvider as NextAuthSessionProvider } from "next-auth/react"
import { useEffect, useState } from "react"

export function SessionProvider({ children }: { children: React.ReactNode }) {
    const [mounted, setMounted] = useState(false)

    useEffect(() => {
        setMounted(true)
    }, [])

    if (!mounted) {
        return null
    }

    return <NextAuthSessionProvider>{children}</NextAuthSessionProvider>
}