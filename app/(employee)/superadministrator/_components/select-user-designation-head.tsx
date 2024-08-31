"use client"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { ExtendedUser } from '@/next-auth';
import React, { useEffect, useState } from 'react';

interface SelectUserProps {
    onUserChange: (userId: string) => void;
    value?: string; // Add value prop
}

const SelectUserDesignationHead: React.FC<SelectUserProps> = ({ onUserChange, value }) => {
    const [users, setUsers] = useState<ExtendedUser[]>([]);

    const makeApiCall = async () => {
        const response = await fetch('/api/users/designationHead', {
            method: 'GET',
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const users = await response.json();
        const processedUsers = users.map((user: any) => {
            const name = user?.firstName + ' ' + user?.lastName;

            return {
                id: user.id,
                name,
            };
        });

        setUsers(processedUsers);
    };

    useEffect(() => {
        makeApiCall();
    }, []);

    const handleChange = (value: string) => {
        // console.log(`Selected user ID: ${value}`);
        onUserChange(value);
    };

    return (
        <Select onValueChange={handleChange} value={value}>
            <SelectTrigger>
                <SelectValue placeholder="Pick a User"></SelectValue>
            </SelectTrigger>
            <SelectContent>
                {users.map(user => (
                    <SelectItem key={user.id} value={user.id}>{user.name}</SelectItem>
                ))}
            </SelectContent>
        </Select>
    );
};

export default SelectUserDesignationHead;