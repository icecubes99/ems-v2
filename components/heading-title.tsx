import { cn } from '@/lib/utils'
import React from 'react'

interface HeadingTitleProps {
    title: string
    children?: React.ReactNode
    className?: string
}
const HeadingTitle = ({ title, children, className }: HeadingTitleProps) => {
    return (
        <div className={cn('mt-5 justify-between items-center flex flex-row', className)}>
            <p className='font-bold text-4xl'>{title}</p>
            {children}
        </div>
    )
}

export default HeadingTitle