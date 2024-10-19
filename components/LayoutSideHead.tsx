"use client"
import { useCurrentUser } from '@/hooks/use-current-user'
import React from 'react'
import Sidebar from './Sidebar';
import Header from './Header';
import { cn } from '@/lib/utils';
import { useUserImage } from '@/hooks/use-user-image';
import { Breadcrumb } from './ui/breadcrumb-header';

interface LayoutSideHeadProps {
    children: React.ReactNode;
    classname?: string
}
const LayoutSideHead = ({ children, classname }: LayoutSideHeadProps) => {
    const user = useCurrentUser();
    const { userImage } = useUserImage();
    return (
        <div className='flex flex-row'>
            <Sidebar />
            <div className='flex flex-col w-full pl-2 '>
                <div className='max-h-screen overflow-y-auto'>
                    <Header user={user} employeePic={userImage || undefined} />
                    <div className={cn('ml-4 mb-20', classname)}>
                        <Breadcrumb />
                        {children}
                    </div>
                </div>
            </div>

        </div>
    )
}

export default LayoutSideHead