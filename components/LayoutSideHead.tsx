"use client"
import { useCurrentUser } from '@/hooks/use-current-user'
import React from 'react'
import Sidebar from './Sidebar';
import Header from './Header';
import { cn } from '@/lib/utils';

interface LayoutSideHeadProps {
    children: React.ReactNode;
    label: string;
    classname?: string
}
const LayoutSideHead = ({ children, label, classname }: LayoutSideHeadProps) => {
    const user = useCurrentUser();
    return (
        <div className='flex flex-row'>
            <Sidebar user={user} />
            <div className='flex flex-col w-full'>
                <Header user={user} />
                <div className={cn('ml-4', classname)}>
                    <p className={cn('font-semibold text-lg')}>{label}</p>
                    {children}
                </div>
            </div>

        </div>
    )
}

export default LayoutSideHead