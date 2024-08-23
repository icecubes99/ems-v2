import Image from 'next/image'
import React from 'react'
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar';
import { FaUser, FaMoneyBill, FaKey, FaDoorOpen, FaAddressBook } from 'react-icons/fa';
import { ExtendedUser } from '@/next-auth';
import { Button } from './ui/button';
import Link from 'next/link';

import { RoleGateNull } from './auth/role-gate-null';
import SidebarButton from './SidebarButton';
import { LogoutButton } from './auth/logout-button';
import { usePathname } from 'next/navigation';


interface SidebarProps {
    user?: ExtendedUser;
}

const Sidebar = ({ user }: SidebarProps) => {
    const router = usePathname();
    return (
        <div className='flex flex-col w-96 bg-purple-200 min-h-screen items-center space-y-10'>
            <div className='mt-7 mb-5'>
                <Link href={"/homepage"}>
                    <Image src={"/kupler.svg"} width={150} height={100} alt='Logo' />
                </Link>
            </div>

            <div>
                <Avatar className='w-24 h-24'>
                    <AvatarImage src={user?.image || undefined} />
                    <AvatarFallback className='bg-neutral-700 text-white'>
                        <FaUser />
                    </AvatarFallback>
                </Avatar>
            </div>

            <div className='text-center'>
                <p className='font-semibold'>
                    {user?.name}
                </p>
                <p className='font-light text-sm'>
                    {user?.jobTitle}
                </p>
            </div>

            <div className='w-full'>

                <SidebarButton link='/employee' icon={<FaUser />} label='PROFILE DETAILS' isActive={router === "/employee"} />
                <SidebarButton link='/' icon={<FaMoneyBill />} label='PAYSLIPS' isActive={router === "/payslips"} />
                <SidebarButton link='/' icon={<FaAddressBook />} label='LEAVE REQUESTS' isActive={router === "/leaveRequests"} />

                <RoleGateNull allowedRole='ADMIN' >
                    <SidebarButton link='/administrator' icon={<FaKey />} label='ADMIN PANEL' isActive={router === "/administrator"} />
                </RoleGateNull>

                <RoleGateNull allowedRole='SUPERADMIN' >
                    <SidebarButton link='/administrator' icon={<FaKey />} label='ADMIN PANEL' isActive={router === "/administrator"} />
                    <SidebarButton link='/' icon={<FaKey />} iconClassname='text-destructive' label='SUPERADMIN PANEL' isActive={router === "/superAdmin"} />
                </RoleGateNull>

                <div className='w-full h-12 items-center hover:bg-destructive/80 inline-block align-bottom'>
                    <LogoutButton>
                        <div className='flex flex-row justify-start h-full items-center'>
                            <FaDoorOpen className='mr-10 ml-16' />
                            <p className='text-sm font-medium'>LOG OUT</p>
                        </div>
                    </LogoutButton>

                </div>


            </div>
        </div>
    )
}

export default Sidebar