"use client"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import React from 'react';
import { useUserListWithDesignationHead } from '@/hooks/use-user-list';
import { Skeleton } from '@/components/ui/skeleton';

interface SelectUserProps {
    onUserChange: (userId: string) => void;
    value?: string;
    designationHeadId?: string;
}

const SelectUserDesignationHead: React.FC<SelectUserProps> = ({
    onUserChange,
    value,
    designationHeadId
}) => {
    const { users, loading, error } = useUserListWithDesignationHead(designationHeadId || '');

    const processedUsers = users.map(user => ({
        id: user.id,
        name: `${user.firstName} ${user.lastName}`
    }));

    if (loading) {
        return <Skeleton className="h-10 w-full" />;
    }

    if (error) {
        return <div>Error loading users</div>;
    }

    return (
        <Select onValueChange={onUserChange} value={value}>
            <SelectTrigger>
                <SelectValue placeholder="Pick a User" />
            </SelectTrigger>
            <SelectContent>
                {processedUsers.map(user => (
                    <SelectItem key={user.id} value={user.id}>
                        {user.name}
                    </SelectItem>
                ))}
            </SelectContent>
        </Select>
    );
};

export default SelectUserDesignationHead;