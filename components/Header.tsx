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
    console.log(user?.jobTitle)

    const userColor =
        user?.role === UserRole.ADMIN ? "text-blue-500" :
            user?.role === UserRole.SUPERADMIN ? "text-red-500" :
                "text-black";
    return (
        <div className='flex w-full h-28 justify-end items-center'>
            <DropdownMenu>
                <DropdownMenuTrigger asChild>
                    <div className='bg-gray-200 cursor-pointer w-80 rounded-md flex justify-between items-center h-20 mr-6 hover:bg-gray-200/50'>
                        <div className='ml-5 flex flex-row items-center space-x-5'>
                            <Avatar>
                                <AvatarImage src={user?.image || undefined} />
                                <AvatarFallback className='bg-neutral-700 text-white'>
                                    <FaUser />
                                </AvatarFallback>
                            </Avatar>
                            <div className='flex flex-col'>
                                <p>
                                    {user?.name}
                                </p>
                                <p className={cn("font-light text-sm", userColor)}>
                                    {user?.jobTitle}
                                </p>
                            </div>
                        </div>
                    </div>
                </DropdownMenuTrigger>

                <DropdownMenuContent className='w-80'>
                    <LogoutButton>
                        <DropdownMenuItem asChild className=''>
                            <Button variant={"destructive"} className='w-full mt-1'>
                                <ExitIcon className="h-4 w-4 mr-2" />
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