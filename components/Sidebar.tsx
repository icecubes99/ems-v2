import Image from 'next/image'
import React from 'react'
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar';
import { FaUser, FaMoneyBill, FaKey, FaDoorOpen, FaAddressBook, FaShieldAlt } from 'react-icons/fa';
import { ExtendedUser } from '@/next-auth';
import { Button } from './ui/button';
import Link from 'next/link';

import { RoleGateNull } from './auth/role-gate-null';
import SidebarButton from './SidebarButton';
import { LogoutButton } from './auth/logout-button';
import { usePathname } from 'next/navigation';
import { IoLogOut } from "react-icons/io5";


interface SidebarProps {
    user?: ExtendedUser;
}

const Sidebar = ({ user }: SidebarProps) => {
    const router = usePathname();
    const isHomepage = router === "/homepage";

    return (
        <div className='flex flex-col w-96 bg-gradient-to-b from-purple-300 to-violet-50 min-h-screen items-center space-y-10 rounded-br-full shadow-xl'>
            <div className='mt-7 mb-5'>
                <Link href={"/homepage"}>
                    <Image
                        src={"/kupler.svg"}
                        className={`hover:bg-purple-100/30 hover:shadow-lg rounded-xl pt-2 pb-1 px-4 ${isHomepage ? 'bg-purple-100/30 shadow-md' : ''}`}
                        width={150}
                        height={100}
                        alt='Logo'
                    />
                </Link>
            </div>

            <div className='items-center flex flex-col gap-4'>
                <Avatar className='w-36 h-36'>
                    <AvatarImage className='border-red-500' src={user?.image || undefined} />
                    <AvatarFallback className='bg-neutral-700 text-white'>
                        <FaUser />
                    </AvatarFallback>
                </Avatar>

                <div className='text-center'>
                    <p className='font-semibold'>
                        {user?.name}
                    </p>
                    <p className='font-light text-sm'>
                        {user?.jobTitle}
                    </p>
                </div>
            </div>

            <div className='w-full'>

                <SidebarButton link='/employee' icon={<FaUser />} label='PROFILE DETAILS' isActive={router.startsWith("/employee")} />
                <SidebarButton link='/payslips' icon={<FaMoneyBill />} label='PAYSLIPS' isActive={router.startsWith("/payslips")} />
                <SidebarButton link='/leaveRequests' icon={<FaAddressBook />} label='LEAVE REQUESTS' isActive={router.startsWith("/leaveRequests")} />

                <RoleGateNull allowedRole='ADMIN' >
                    <SidebarButton link='/administrator' icon={<FaKey />} iconClassname='text-sky-900' isAdmin label='ADMIN PANEL' isActive={router.startsWith("/administrator")} />
                </RoleGateNull>

                <RoleGateNull allowedRole='SUPERADMIN' >
                    <SidebarButton link='/administrator' icon={<FaKey />} iconClassname='text-sky-950' isAdmin label='ADMIN PANEL' isActive={router.startsWith("/administrator")} />
                    <SidebarButton link='/superadministrator' icon={<FaShieldAlt />} iconClassname='text-red-900' label='SUPERADMIN PANEL' isSuperAdmin isActive={router.startsWith("/superadministrator")} />
                </RoleGateNull>

                <div className='w-full h-12 items-center hover:bg-gradient-to-r from-red-200 to-rose-400 inline-block align-bottom'>
                    <LogoutButton userId={user?.id as string}>
                        <div className='flex flex-row justify-start h-full items-center'>
                            <IoLogOut className='mr-10 ml-16' />
                            <p className='text-sm font-medium'>LOG OUT</p>
                        </div>
                    </LogoutButton>

                </div>


            </div>
        </div>
    )
}

export default Sidebar