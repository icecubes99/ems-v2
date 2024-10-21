'use client'

import { ThemeProvider } from "next-themes"
import { useCurrentUser } from '@/hooks/use-current-user'
import React from 'react'
import Sidebar from './Sidebar'
import Header from './Header'
import { cn } from '@/lib/utils'
import { useUserImage } from '@/hooks/use-user-image'
import { Breadcrumb } from './ui/breadcrumb-header'
import { ThemeToggle } from "./theme-toggle"

interface LayoutSideHeadProps {
    children: React.ReactNode;
    classname?: string
}

const LayoutSideHead = ({ children, classname }: LayoutSideHeadProps) => {
    const user = useCurrentUser();
    const { userImage } = useUserImage();

    return (
        <ThemeProvider attribute="class" defaultTheme="system" enableSystem>
            <div className='flex flex-row dark:bg-[#121212]'>
                <Sidebar />
                <div className='flex flex-col w-full pl-2'>
                    <div className='max-h-screen overflow-y-auto'>
                        <Header user={user} employeePic={userImage || undefined} />
                        <div className={cn('ml-4 mb-20', classname)}>
                            <div className="flex justify-between items-center">
                                <Breadcrumb />
                                <ThemeToggle />
                            </div>
                            <div className='mr-6 dark:text-white'>
                                {children}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ThemeProvider>
    )
}

export default LayoutSideHead