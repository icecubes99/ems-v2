"use client"
import { useState, useEffect } from 'react';
import { getDesignationFromDepartment } from '@/actions/superadmin/getDesignations';
import { Designation } from '@prisma/client';

interface UseDepartmentResult {
    data: Designation[] | null;
    loading: boolean;
    error: string | null;
}

const useDesignationFromDepartment = (departmentId: string): UseDepartmentResult => {
    const [data, setData] = useState<Designation[] | null>(null);
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchDepartment = async () => {
            setLoading(true);
            setError(null);

            try {
                const result = await getDesignationFromDepartment(departmentId);

                if (result.error) {
                    setError(result.error);
                    setData(null);
                } else {
                    setData(result.data as Designation[]);
                }
            } catch (err) {
                setError('An error occurred while fetching the department.');
                setData(null);
            } finally {
                setLoading(false);
            }
        };

        fetchDepartment();
    }, [departmentId]);

    return { data, loading, error };
};

export default useDesignationFromDepartment;