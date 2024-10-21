import { cn } from '@/lib/utils'
import Link from 'next/link'
import React from 'react'

interface SidebarButtonProps {
    link: string
    icon: React.ReactNode
    label: string
    classname?: string
    iconClassname?: string
    isActive: boolean
    isSuperAdmin?: boolean
    isAdmin?: boolean
    isCollapsed: boolean
}

const SidebarButton = ({
    link,
    icon,
    label,
    classname,
    iconClassname,
    isActive,
    isSuperAdmin,
    isAdmin,
    isCollapsed
}: SidebarButtonProps) => {
    return (
        <Link href={link} passHref>
            <div
                className={cn(
                    `w-full cursor-pointer h-12 flex items-center transition-all duration-300 ease-in-out
                    ${isActive ? 'bg-gradient-to-r from-purple-300 to-violet-300 shadow-md dark:from-purple-700 dark:to-violet-700' : 'hover:bg-gradient-to-r from-purple-300 to-violet-300 dark:hover:from-purple-700 dark:hover:to-violet-700'} 
                    ${isSuperAdmin ? "hover:bg-gradient-to-r from-purple-300 to-red-300 dark:hover:from-purple-700 dark:hover:to-red-700  dark:from-purple-700 dark:to-red-700" : ""}
                    ${isAdmin ? "hover:bg-gradient-to-r from-purple-300 to-indigo-300 dark:hover:from-purple-700 dark:hover:to-indigo-700 dark:from-purple-700 dark:to-indigo-700" : ""}
                    ${isCollapsed ? 'justify-center' : 'justify-start'}`,
                    classname
                )}
            >
                <div
                    className={cn(
                        "flex items-center transition-all duration-300 ease-in-out",
                        isCollapsed ? "justify-center" : "justify-start w-full",
                        iconClassname
                    )}
                >
                    <div className={`transition-all duration-500 ease-in-out
                        ${isCollapsed ? "" : "mr-10 ml-16"}
                        ${isActive ? "dark:text-white" : ""}
                        `}>
                        {icon}
                    </div>
                    <div className={`text-sm font-medium flex flex-col items-center gap-4 ${isCollapsed ? 'opacity-0 w-0' : 'opacity-100 w-auto open'} dark:text-gray-200`}
                        style={{
                            transform: isCollapsed ? 'scale(0.8) translateX(-5px)' : 'scale(1) translateX(0)',
                            transition: isCollapsed ? 'none' : 'transform 0.5s ease-in-out, opacity 0.5s ease-in-out'
                        }}>
                        {label}
                    </div>
                </div>
            </div>
        </Link>
    )
}

export default SidebarButton