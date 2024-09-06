// hooks/useAssignedUsers.ts
'use client'

import { useState, useEffect, useCallback } from 'react';
import { AssignDesignationWithUser } from '@/types/types';
import { fetchAssignedUsers } from '@/actions/administrator/fetchAssignedUsers';

export function useAssignedUsers(designationId: string) {
    const [assignedUsers, setAssignedUsers] = useState<AssignDesignationWithUser[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const loadAssignedUsers = useCallback(async () => {
        setIsLoading(true);
        setError(null);
        try {
            const data = await fetchAssignedUsers(designationId);
            setAssignedUsers(data);
        } catch (err) {
            setError('An error occurred while fetching data');
            console.error('Error fetching assigned users:', err);
        } finally {
            setIsLoading(false);
        }
    }, [designationId]);

    useEffect(() => {
        loadAssignedUsers();
    }, [loadAssignedUsers]);

    const refetch = useCallback(() => {
        loadAssignedUsers();
    }, [loadAssignedUsers]);

    return { assignedUsers, isLoading, error, refetch };
}