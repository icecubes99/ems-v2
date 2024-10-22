'use client'

import Image from 'next/image'
import React, { useState, useEffect } from 'react'
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar'
import { FaUser, FaMoneyBill, FaKey, FaAddressBook, FaShieldAlt, FaChevronRight } from 'react-icons/fa'
import { ExtendedUser } from '@/next-auth'
import Link from 'next/link'
import { RoleGateNull } from './auth/role-gate-null'
import SidebarButton from './SidebarButton'
import { LogoutButton } from './auth/logout-button'
import { usePathname } from 'next/navigation'
import { IoLogOut } from "react-icons/io5"
import { useCurrentUser } from '@/hooks/use-current-user'
import { useUserImage } from '@/hooks/use-user-image'
import { Button } from './ui/button'
import { Skeleton } from './ui/skeleton'
import SidebarEnhancements from './sidebar-enhancements'
import { useTheme } from 'next-themes'
import {
    Tooltip,
    TooltipContent,
    TooltipProvider,
    TooltipTrigger,
} from "@/components/ui/tooltip"

interface SidebarProps {
    user?: ExtendedUser
}

export default function Sidebar({ }: SidebarProps) {
    const [isCollapsed, setIsCollapsed] = useState(true)
    const [isClient, setIsClient] = useState(false)
    const user = useCurrentUser()
    const router = usePathname()
    const isHomepage = router === "/homepage"
    const { userImage } = useUserImage()
    const { theme } = useTheme()

    const getLogo = () => {
        if (isCollapsed) {
            return theme === 'dark' ? "/kDark.svg" : "/k.svg"
        } else {
            return theme === 'dark' ? "/kuplerDark.svg" : "/kupler.svg"
        }
    }

    useEffect(() => {
        setIsClient(true)
        const savedState = localStorage.getItem('sidebarCollapsed')
        setIsCollapsed(savedState === 'true')

        const handleKeyDown = (event: KeyboardEvent) => {
            if (event.metaKey && event.key === 'b') {
                event.preventDefault()
                toggleSidebar()
            }
        }

        window.addEventListener('keydown', handleKeyDown)

        return () => {
            window.removeEventListener('keydown', handleKeyDown)
        }
    }, [])

    useEffect(() => {
        if (isClient) {
            localStorage.setItem('sidebarCollapsed', isCollapsed.toString())
        }
    }, [isCollapsed, isClient])

    const toggleSidebar = () => {
        setIsCollapsed(prev => !prev)
    }

    if (!isClient) {
        return (
            <Skeleton className="w-96 h-screen bg-gradient-to-b from-purple-300 to-violet-50 min-h-screen dark:from-black dark:to-black rounded-br-3xl shadow-xl" />
        )
    }

    const userTimeZone = "Asia/Manila"

    return (
        <div
            className={`flex flex-col ${isCollapsed ? 'w-20' : 'w-96'}
                bg-gradient-to-b from-purple-300 to-violet-50 dark:from-black dark:to-black
                min-h-screen rounded-br-3xl shadow-xl transition-all duration-300 ease-in-out relative`}
        >

            <Button
                onClick={toggleSidebar}
                className="absolute -right-3 top-5 bg-purple-400 hover:bg-purple-500 rounded-full p-1 transition-transform duration-300 ease-in-out"
                size="icon"
                style={{ transform: isCollapsed ? 'rotate(0deg)' : 'rotate(180deg)' }}
            >
                <FaChevronRight />
            </Button>
            <div className="flex flex-col items-center space-y-8 flex-grow">
                <div className="mt-7 mb-5">
                    <Link href="/homepage">
                        <Image
                            src={getLogo()}
                            className={`hover:bg-purple-100/30 dark:hover:bg-white/10 hover:shadow-lg rounded-xl pt-2 pb-1 px-4 transition duration-300 ease-in-out ${isHomepage ? 'bg-purple-100/30 shadow-md dark:bg-white/10' : ''}`}
                            width={isCollapsed ? 50 : 150}
                            height={isCollapsed ? 33 : 100}
                            alt="Logo"
                        />
                    </Link>
                </div>
                <div className="flex flex-col items-center gap-4 transition-all duration-300 ease-in-out" style={{ transform: isCollapsed ? 'scale(0.8)' : 'scale(1)' }}>
                    <Avatar className={`transition-all duration-300 ease-in-out ${isCollapsed ? "w-12 h-12" : "w-20 h-20 md:w-32 md:h-32 lg:w-36 lg:h-36"}`}>
                        <AvatarImage src={userImage || undefined} />
                        <AvatarFallback className="bg-neutral-700 text-white">
                            <FaUser />
                        </AvatarFallback>
                    </Avatar>
                    <div className={`text-center transition-all duration-300 ease-in-out ${isCollapsed ? 'opacity-0 scale-0' : 'opacity-100 scale-100'}`}>
                        <p className="font-semibold">{user?.name}</p>
                        <p className="font-light text-sm">{user?.jobTitle}</p>
                    </div>
                </div>
                <SidebarEnhancements
                    isCollapsed={isCollapsed}
                    userTimeZone={userTimeZone}
                />

            </div>

            <div className="mb-auto">
                <SidebarButton
                    link="/employee"
                    icon={<FaUser />}
                    label="PROFILE DETAILS"
                    isActive={router.startsWith("/employee")}
                    isCollapsed={isCollapsed}
                />
                <SidebarButton
                    link="/payslips"
                    icon={<FaMoneyBill />}
                    label="PAYSLIPS"
                    isActive={router.startsWith("/payslips")}
                    isCollapsed={isCollapsed}
                />
                <SidebarButton
                    link="/leaveRequests"
                    icon={<FaAddressBook />}
                    label="LEAVE REQUESTS"
                    isActive={router.startsWith("/leaveRequests")}
                    isCollapsed={isCollapsed}
                />
                <RoleGateNull allowedRole="ADMIN">
                    <SidebarButton
                        link="/administrator"
                        icon={<FaKey />}
                        iconClassname="text-sky-900 dark:text-sky-700  dark:hover:text-white"
                        isAdmin
                        label="ADMIN PANEL"
                        isActive={router.startsWith("/administrator")}
                        isCollapsed={isCollapsed}
                    />
                </RoleGateNull>
                <RoleGateNull allowedRole="SUPERADMIN">
                    <SidebarButton
                        link="/administrator"
                        icon={<FaKey />}
                        iconClassname="text-sky-950 dark:text-sky-700  dark:hover:text-white"
                        isAdmin
                        label="ADMIN PANEL"
                        isActive={router.startsWith("/administrator")}
                        isCollapsed={isCollapsed}
                    />
                    <SidebarButton
                        link="/superadministrator"
                        icon={<FaShieldAlt />}
                        iconClassname="text-red-900 dark:text-pink-700  dark:hover:text-white"
                        label="SUPERADMIN PANEL"
                        isSuperAdmin
                        isActive={router.startsWith("/superadministrator")}
                        isCollapsed={isCollapsed}
                    />
                </RoleGateNull>
            </div>

            <div className="mt-auto mb-14">
                <LogoutButton userId={user?.id as string}>
                    <SidebarButton
                        link="/logout"
                        icon={<IoLogOut />}
                        label="LOG OUT"
                        isActive={router.startsWith("/logout")}
                        isCollapsed={isCollapsed}
                        classname=' hover:bg-gradient-to-r from-red-200 to-red-400 transition-all duration-300 ease-in-out '
                    />
                </LogoutButton>
            </div>
        </div>
    )
}