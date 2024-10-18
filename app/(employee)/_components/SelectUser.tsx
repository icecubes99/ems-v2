"use client"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { useUserList } from '@/hooks/use-user-list';
import { ExtendedUser } from '@/next-auth';
import { User } from '@prisma/client';
import React, { useEffect, useState } from 'react';

interface SelectUserProps {
    onUserChange: (userId: string) => void;
    value?: string; // Add value prop
}
interface MultiSelectUserProps {
    onUserChangeArr: (userId: string[]) => void;
    value: string;
}
const SelectUser: React.FC<SelectUserProps> = ({ onUserChange, value }) => {
    const [users, setUsers] = useState<User[]>([]);

    const { users: user } = useUserList();

    useEffect(() => {
        if (user) {
            setUsers(user);
        }
    }, [user])

    const handleChange = (value: string) => {
        onUserChange(value);
    };

    return (
        <Select onValueChange={handleChange} value={value}>
            <SelectTrigger>
                <SelectValue placeholder="Pick a User"></SelectValue>
            </SelectTrigger>
            <SelectContent>
                {users.map(user => (
                    <SelectItem key={user.id} value={user.id}>{user.firstName + " " + user.lastName}</SelectItem>
                ))}
            </SelectContent>
        </Select>
    );
};

export default SelectUser;