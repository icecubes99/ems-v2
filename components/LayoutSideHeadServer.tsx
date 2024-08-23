"use client"
import { useCurrentUser } from '@/hooks/use-current-user'
import React from 'react'
import Sidebar from './Sidebar';
import Header from './Header';
import { currentUser } from '@/lib/auth';

interface LayoutSideHeadProps {
    children: React.ReactNode;
    label: string;
}
const LayoutSideHeadServer = async ({ children, label }: LayoutSideHeadProps) => {
    const user = await currentUser();
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

export default LayoutSideHeadServer