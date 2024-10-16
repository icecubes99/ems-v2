import Image from 'next/image'
import React from 'react'
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar'
import { FaUser, FaMoneyBill, FaKey, FaAddressBook, FaShieldAlt } from 'react-icons/fa'
import { ExtendedUser } from '@/next-auth'
import Link from 'next/link'
import { RoleGateNull } from './auth/role-gate-null'
import SidebarButton from './SidebarButton'
import { LogoutButton } from './auth/logout-button'
import { usePathname } from 'next/navigation'
import { IoLogOut } from "react-icons/io5"
import { useCurrentUser } from '@/hooks/use-current-user'
import { useUserImage } from '@/hooks/use-user-image'

interface SidebarProps {
    user?: ExtendedUser
}

export default function Component({ }: SidebarProps) {
    const user = useCurrentUser()
    const router = usePathname()
    const isHomepage = router === "/homepage"
    const { userImage, } = useUserImage()

    return (
        <div className="flex flex-col w-96 bg-gradient-to-b from-purple-300 to-violet-50 min-h-screen rounded-br-3xl shadow-xl">
            <div className="flex flex-col items-center space-y-10 flex-grow">
                <div className="mt-7 mb-5">
                    <Link href="/homepage">
                        <Image
                            src="/kupler.svg"
                            className={`hover:bg-purple-100/30 hover:shadow-lg rounded-xl pt-2 pb-1 px-4 transition duration-300 ease-in-out ${isHomepage ? 'bg-purple-100/30 shadow-md' : ''
                                }`}
                            width={150}
                            height={100}
                            alt="Logo"
                        />
                    </Link>
                </div>
                <div className="flex flex-col items-center gap-4">
                    <Avatar className="w-20 h-20 md:w-32 md:h-32 lg:w-36 lg:h-36">
                        <AvatarImage src={userImage || undefined} />
                        <AvatarFallback className="bg-neutral-700 text-white">
                            <FaUser />
                        </AvatarFallback>
                    </Avatar>
                    <div className="text-center">
                        <p className="font-semibold">{user?.name}</p>
                        <p className="font-light text-sm">{user?.jobTitle}</p>
                    </div>
                </div>
                <div className="w-full flex-grow">
                    <SidebarButton
                        link="/employee"
                        icon={<FaUser />}
                        label="PROFILE DETAILS"
                        isActive={router.startsWith("/employee")}
                    />
                    <SidebarButton
                        link="/payslips"
                        icon={<FaMoneyBill />}
                        label="PAYSLIPS"
                        isActive={router.startsWith("/payslips")}
                    />
                    <SidebarButton
                        link="/leaveRequests"
                        icon={<FaAddressBook />}
                        label="LEAVE REQUESTS"
                        isActive={router.startsWith("/leaveRequests")}
                    />
                    <RoleGateNull allowedRole="ADMIN">
                        <SidebarButton
                            link="/administrator"
                            icon={<FaKey />}
                            iconClassname="text-sky-900"
                            isAdmin
                            label="ADMIN PANEL"
                            isActive={router.startsWith("/administrator")}
                        />
                    </RoleGateNull>
                    <RoleGateNull allowedRole="SUPERADMIN">
                        <SidebarButton
                            link="/administrator"
                            icon={<FaKey />}
                            iconClassname="text-sky-950"
                            isAdmin
                            label="ADMIN PANEL"
                            isActive={router.startsWith("/administrator")}
                        />
                        <SidebarButton
                            link="/superadministrator"
                            icon={<FaShieldAlt />}
                            iconClassname="text-red-900"
                            label="SUPERADMIN PANEL"
                            isSuperAdmin
                            isActive={router.startsWith("/superadministrator")}
                        />
                    </RoleGateNull>
                </div>
            </div>
            <div className="mt-auto mb-14">
                <LogoutButton userId={user?.id as string}>
                    <div className="flex items-center w-full h-12 hover:bg-gradient-to-r from-red-200 to-red-400">
                        <IoLogOut className="mr-10 ml-16" />
                        <p className="text-sm font-medium">LOG OUT</p>
                    </div>
                </LogoutButton>
            </div>
        </div>
    )
}