// hooks/useTotalUserCount.ts
import { useState, useEffect } from 'react'
import { fetchUsersCount } from '@/actions/fetchModelCounts'
import { fetchDepartmentsCount } from '@/actions/fetchModelCounts';
import { fetchDesignationsCount } from '@/actions/fetchModelCounts';

export function useTotalUserCount() {
    const [userCount, setUserCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getUsersCount() {
            try {
                setIsLoading(true);
                const count = await fetchUsersCount();
                setUserCount(count);
            } catch (err) {
                console.error("Error fetching user count: ", err);
                setError("Failed to fetch Users Count");
            } finally {
                setIsLoading(false);
            }
        }

        getUsersCount();
    }, []);

    return { userCount, isLoading, error };
}


export function useTotalDepartmentsCount() {
    const [departmentCount, setDepartmentCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getDepartmentsCount() {
            try {
                setIsLoading(true);
                const count = await fetchDepartmentsCount();
                setDepartmentCount(count);
            } catch (err) {
                console.error("Error fetching department count: ", err);
                setError("Failed to fetch Department Count");
            } finally {
                setIsLoading(false);
            }
        }

        getDepartmentsCount();
    }, []);

    return { departmentCount, isLoading, error };
}

export function useTotalDesignationCount() {
    const [designationCount, setDesignationCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getDesignationCount() {
            try {
                setIsLoading(true);
                const count = await fetchDesignationsCount();
                setDesignationCount(count);
            } catch (err) {
                console.error("Error fetching designation count: ", err);
                setError("Failed to fetch Designation Count");
            } finally {
                setIsLoading(false);
            }
        }

        getDesignationCount();
    }, []);

    return { designationCount, isLoading, error };
}

