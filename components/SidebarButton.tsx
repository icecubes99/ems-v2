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
                    ${isActive ? 'bg-gradient-to-r from-purple-300 to-violet-300 shadow-md' : 'hover:bg-gradient-to-r from-purple-300 to-violet-300'} 
                    ${isSuperAdmin ? "hover:bg-gradient-to-r from-purple-300 to-red-300" : ""}
                    ${isAdmin ? "hover:bg-gradient-to-r from-purple-300 to-indigo-300" : ""}
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
                    <div className={`transition-all duration-300 ease-in-out ${isCollapsed ? "" : "mr-10 ml-16"}`}>
                        {icon}
                    </div>
                    {/* <p className={`text-sm font-medium transition-all duration-300 ease-in-out ${isCollapsed ? 'opacity-0 w-0' : 'opacity-100 w-auto'}`}> */}
                    <div className={`text-sm font-medium flex flex-col items-center gap-4 transition-all duration-150 ease-in-out  ${isCollapsed ? 'opacity-0 w-0' : 'opacity-100 w-auto'}`}
                        style={{ transform: isCollapsed ? 'scale(0.8)' : 'scale(1)' }}>

                        {label}
                    </div>
                    {/* </p> */}
                </div>
            </div>
        </Link>
    )
}

export default SidebarButton