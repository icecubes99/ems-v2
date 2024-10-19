import React from 'react'

interface QuickActionsProps {
    children: React.ReactNode
    title?: string

}

const QuickActions = ({ children, title }: QuickActionsProps) => {
    return (
        <>
            <p className="col-span-4 font-bold text-lg mt-6">{title || "QUICK ACTIONS"}</p>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6 items-center justify-center">
                {children}
            </div>
        </>
    )
}

export default QuickActions