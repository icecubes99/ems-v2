"use client"
import { useCurrentUser } from '@/hooks/use-current-user'
import React from 'react'
import Sidebar from './Sidebar';
import Header from './Header';

interface LayoutSideHeadProps {
    children: React.ReactNode;
    label: string;
}
const LayoutSideHead = ({ children, label }: LayoutSideHeadProps) => {
    const user = useCurrentUser();
    return (
        <div className='flex flex-row'>
            <Sidebar user={user} />
            <div className='flex flex-col w-full'>
                <Header user={user} />
                <div className='ml-4'>
                    <p className='font-semibold text-lg'>{label}</p>
                    {children}
                </div>
            </div>

        </div>
    )
}

export default LayoutSideHead