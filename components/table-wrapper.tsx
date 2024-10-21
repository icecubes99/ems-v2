import { cn } from '@/lib/utils'
import React from 'react'

interface TableWrapperProps {
    title: string
    description: string
    children: React.ReactNode
    icon?: React.ReactNode
    className?: string
}

const TableWrapper = ({ title, description, children, icon, className }: TableWrapperProps) => {
    return (
        <div className={cn('bg-card mt-5  rounded-xl border border-white shadow-md hover:shadow-lg transition duration-300 dark:border-white/10', className)}>
            <div className='p-6 border-b border-border'>
                <h2 className='text-2xl font-semibold flex items-center gap-2'>
                    {icon && React.cloneElement(icon as React.ReactElement, { className: "h-6 w-6 text-primary" })}
                    {title}
                </h2>
                <p className='text-muted-foreground mt-1'>{description}</p>
            </div>
            <div className='p-6'>
                {children}
            </div>
        </div>
    )
}

export default TableWrapper