import React from 'react'
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar'
import { FaUser } from 'react-icons/fa'
import { UserRole } from '@prisma/client'
import { cn } from '@/lib/utils'
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@radix-ui/react-dropdown-menu'
import { LogoutButton } from './auth/logout-button'
import { ExitIcon } from '@radix-ui/react-icons'
import { Button } from './ui/button'
import { ExtendedUser } from '@/next-auth'

interface HeaderProps {
    employeePic?: string
    user?: ExtendedUser
}

const Header = ({ user, employeePic }: HeaderProps) => {
    const userColor =
        user?.role === UserRole.ADMIN ? 'text-blue-900 dark:text-blue-400' :
            user?.role === UserRole.SUPERADMIN ? 'text-red-900 dark:text-red-400' :
                'text-black dark:text-white'

    return (
        <div className='flex w-full h-28 justify-end items-center'>
            <DropdownMenu>
                <DropdownMenuTrigger asChild>
                    <div className='bg-gradient-to-r mr-6 from-purple-200 from-50% via-purple-50 via-90% to-purple-50/30 cursor-pointer w-80 shadow-md rounded-full flex justify-between items-center h-20 hover:bg-purple-200/50 focus:bg-purple-200/50 transition-all duration-1000 ease-in-out dark:from-black dark:to-black/30 dark:hover:bg-purple-800/50 '>
                        <div className='ml-5 flex flex-row items-center space-x-5'>
                            <Avatar>
                                <AvatarImage src={employeePic || undefined} />
                                <AvatarFallback className='bg-neutral-700 text-white'>
                                    <FaUser />
                                </AvatarFallback>
                            </Avatar>
                            <div className='flex flex-col'>
                                <p className='font-semibold text-purple-900 dark:text-white'>
                                    {user?.name}
                                </p>
                                <p className={cn('font-normal text-sm', userColor)}>
                                    {user?.jobTitle}
                                </p>
                            </div>
                        </div>
                    </div>
                </DropdownMenuTrigger>

                <DropdownMenuContent className='w-80 dark:bg-gray-800 dark:text-gray-200'>
                    <LogoutButton userId={user?.id as string}>
                        <DropdownMenuItem asChild>
                            <Button variant={'destructive'} className='rounded-l-full w-full mt-1 dark:bg-red-700 dark:text-white'>
                                <ExitIcon className='h-4 w-4 mr-2' />
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