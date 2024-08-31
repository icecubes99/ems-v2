"use client"

import { useState, useEffect } from 'react';
import { getDesignationUsers } from '@/actions/superadmin/getDesignationUsers';
import { AssignDesignation } from '@prisma/client';

interface UseDesignationUsersResult {
    data: AssignDesignation[] | null;
    loading: boolean;
    error: string | null;
}

const useAssignedUsersInADesignation = (designationId: string): UseDesignationUsersResult => {
    const [data, setData] = useState<AssignDesignation[] | null>(null);
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchDesignationUsers = async () => {
            setLoading(true);
            setError(null);

            try {
                const result = await getDesignationUsers(designationId);

                if (result.error) {
                    setError(result.error);
                    setData(null);
                } else {
                    setData(result.data as AssignDesignation[]);
                }
            } catch (err) {
                setError('An error occurred while fetching the designation users.');
                setData(null);
            } finally {
                setLoading(false);
            }
        };

        fetchDesignationUsers();

    }, [designationId]);

    return { data, loading, error };

}

export default useAssignedUsersInADesignation;