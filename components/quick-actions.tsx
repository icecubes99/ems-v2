import { cn } from '@/lib/utils'
import React from 'react'

interface QuickActionsProps {
    children: React.ReactNode
    title?: string
    className?: string

}

const QuickActions = ({ children, title, className }: QuickActionsProps) => {
    return (
        <>
            <p className="col-span-4 font-bold text-lg mt-6">{title || "QUICK ACTIONS"}</p>
            <div className={cn("grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-3 items-center justify-center", className)}>
                {children}
            </div>
        </>
    )
}

export default QuickActions