"use client"
import React, { useEffect, useState } from 'react'
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "@/components/ui/table"

import { Account, Gender, TwoFactorConfirmation, UserRole } from '@prisma/client';


interface UserList {
    id: string;
    firstName: string;
    middleName: string;
    lastName: string;
    gender: Gender;
    birthDate: Date;
    jobTitle: string;
    email: string;
    role: UserRole;
    emailVerified: Date;
    image: string;
    password: string;
    accounts: Account[];
    isTwoFactorEnabled: boolean;
    twoFactorConfirmation: TwoFactorConfirmation;
    twoFactorConfirmationId: string;
}

const UserList: React.FC = () => {
    const [users, setUsers] = useState<UserList[]>([]);

    const makeApiCall = async () => {
        const response = await fetch('/api/users', {
            method: 'GET',
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const users = await response.json();
        setUsers(users);
        console.log("THIS IS THE RESPONSE" + setUsers)
    };

    useEffect(() => {
        makeApiCall();
    }, [])

    return (
        <Table className='mt-2'>
            <TableCaption>All of the Users in the Employee Management System.</TableCaption>
            <TableHeader>
                <TableRow>
                    <TableHead className="">Role</TableHead>
                    <TableHead>First Name</TableHead>
                    <TableHead>Middle Name</TableHead>
                    <TableHead>Last Name</TableHead>
                    <TableHead className="text-right">Role</TableHead>
                </TableRow>
            </TableHeader>
            <TableBody>
                {users.map((userObj, index) => (
                    <TableRow key={index}>
                        <TableCell className="font-medium">{userObj.role}</TableCell>
                        <TableCell>{userObj?.firstName}</TableCell>
                        <TableCell>{userObj.middleName}</TableCell>
                        <TableCell>{userObj.lastName}</TableCell>
                        <TableCell className="text-right">{userObj.role}</TableCell>
                    </TableRow>
                ))}
            </TableBody>
        </Table>

    )
}

export default UserList