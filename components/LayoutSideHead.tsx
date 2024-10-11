"use client"
import { useCurrentUser } from '@/hooks/use-current-user'
import React from 'react'
import Sidebar from './Sidebar';
import Header from './Header';
import { cn } from '@/lib/utils';
import { useUserImage } from '@/hooks/use-user-image';

interface LayoutSideHeadProps {
    children: React.ReactNode;
    label: string;
    classname?: string
}
const LayoutSideHead = ({ children, label, classname }: LayoutSideHeadProps) => {
    const user = useCurrentUser();
    const { userImage } = useUserImage();
    return (
        <div className='flex flex-row'>
            <Sidebar />
            <div className='flex flex-col w-full pl-2 '>
                <div className='max-h-screen overflow-y-auto'>
                    <Header user={user} employeePic={userImage || undefined} />
                    <div className={cn('ml-4 mb-20', classname)}>
                        <p className={cn('font-semibold text-lg')}>{label}</p>
                        {children}
                    </div>
                </div>
            </div>

        </div>
    )
}

export default LayoutSideHead