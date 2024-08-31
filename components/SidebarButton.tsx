import { cn } from '@/lib/utils';
import Link from 'next/link';
import React from 'react'

interface SidebarButtonProps {
    children?: React.ReactNode;
    link: string;
    icon: React.ReactNode;
    label: string;
    classname?: string;
    iconClassname?: string;
    isActive: boolean;
    isSuperAdmin?: boolean;
    isAdmin?: boolean;
}

const SidebarButton = ({ children, link, icon, label, classname, iconClassname, isActive, isSuperAdmin, isAdmin }: SidebarButtonProps) => {
    return (
        <div className={cn(`w-full h-12 items-center hover:bg-gradient-to-r from-purple-300 to-violet-300 
        ${isActive ? 'bg-gradient-to-r from-purple-300 to-violet-300 shadow-md' : 'hover:bg-gradient-to-r from-purple-300 to-violet-300'} 
        ${isSuperAdmin ? "hover:bg-gradient-to-r from-purple-300 to-red-300" : ""}
        ${isAdmin ? "hover:bg-gradient-to-r from-purple-300 to-indigo-300" : ""}
        
        `, classname)}>
            <Link href={link}>
                <div className='flex flex-row justify-start h-full items-center'>
                    <div className={cn("mr-10 ml-16", iconClassname)}>
                        {icon}
                    </div>
                    <p className='text-sm font-medium'>{label}</p>
                </div>
            </Link>
        </div>
    )
}

export default SidebarButton