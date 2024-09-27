import React from 'react'

interface QuickActionsProps {
    children: React.ReactNode

}

const QuickActions = ({ children }: QuickActionsProps) => {
    return (
        <>
            <p className="col-span-4 font-bold text-lg mt-6">QUICK ACTIONS</p>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6">
                {children}
            </div>
        </>
    )
}

export default QuickActions