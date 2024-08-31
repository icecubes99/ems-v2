import React, { use } from 'react'
import { Card, CardContent } from './ui/card'
import { ExtendedUser } from '@/next-auth'
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar';
import { FaUser } from 'react-icons/fa';
import { UserRole } from '@prisma/client'
import { cn } from '@/lib/utils';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@radix-ui/react-dropdown-menu';
import { LogoutButton } from './auth/logout-button';
import { ExitIcon } from '@radix-ui/react-icons';
import { Button } from './ui/button';


interface HeaderProps {
    employeePic?: string;
    user?: ExtendedUser;
}
const Header = ({ user, employeePic }: HeaderProps) => {

    const userColor =
        user?.role === UserRole.ADMIN ? "text-blue-900" :
            user?.role === UserRole.SUPERADMIN ? "text-red-900" :
                "text-black";
    return (
        <div className='flex w-full h-28 justify-end items-center'>
            <DropdownMenu>
                <DropdownMenuTrigger asChild>
                    <div className='bg-gradient-to-r from-purple-100  cursor-pointer w-80 shadow-md rounded-l-full flex justify-between items-center h-20 mr-6 hover:bg-purple-200/50 focus:bg-purple-200/50'>
                        <div className='ml-5 flex flex-row items-center space-x-5'>
                            <Avatar>
                                <AvatarImage src={user?.image || undefined} />
                                <AvatarFallback className='bg-neutral-700 text-white'>
                                    <FaUser />
                                </AvatarFallback>
                            </Avatar>
                            <div className='flex flex-col'>
                                <p className='font-semibold text-purple-950'>
                                    {user?.name}
                                </p>
                                <p className={cn("font-normal text-sm", userColor)}>
                                    {user?.jobTitle}
                                </p>
                            </div>
                        </div>
                    </div>
                </DropdownMenuTrigger>

                <DropdownMenuContent className='w-80'>
                    <LogoutButton userId={user?.id as string}>
                        <DropdownMenuItem asChild className=''>
                            <Button variant={"destructive"} className='rounded-l-full w-full mt-1'>
                                <ExitIcon className=" h-4 w-4 mr-2" />
                                Logout
                            </Button>
                        </DropdownMenuItem>
                    </LogoutButton>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>
    )
}

export default Header