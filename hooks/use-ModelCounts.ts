// hooks/useTotalUserCount.ts
import { useState, useEffect } from 'react'
import { fetchActiveUsersCount, fetchInactiveUsersCount, fetchLeavesPendingCount, fetchOvertimesPendingCount, fetchUserBasicSalary, fetchUserPayslipCount, fetchUsersCount } from '@/actions/fetchModelCounts'
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

export function useOvertimesPendingCount() {
    const [pendingOvertimesCount, setPendingOvertimesCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getPendingOvertimesCount() {
            try {
                setIsLoading(true);
                const count = await fetchOvertimesPendingCount();
                setPendingOvertimesCount(count);
            } catch (err) {
                console.error("Error fetching pending Overtimes count: ", err);
                setError("Failed to fetch Pending Overtimes Count");
            } finally {
                setIsLoading(false);
            }
        }

        getPendingOvertimesCount();
    }, []);

    return { pendingOvertimesCount, isLoading, error };
}


export function useLeavesPendingCount() {
    const [pendingLeavesCount, setPendingLeavesCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getPendingLeavesCount() {
            try {
                setIsLoading(true);
                const count = await fetchLeavesPendingCount();
                setPendingLeavesCount(count);
            } catch (err) {
                console.error("Error fetching pending Leaves count: ", err);
                setError("Failed to fetch Pending Leaves Count");
            } finally {
                setIsLoading(false);
            }
        }

        getPendingLeavesCount();
    }, []);

    return { pendingLeavesCount, isLoading, error };
}



export function useTotalActiveUserCount() {
    const [activeUsersCount, setUserCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getUsersCount() {
            try {
                setIsLoading(true);
                const count = await fetchActiveUsersCount();
                setUserCount(count);
            } catch (err) {
                console.error("Error fetching Active User count: ", err);
                setError("Failed to fetch Active Users Count");
            } finally {
                setIsLoading(false);
            }
        }

        getUsersCount();
    }, []);

    return { activeUsersCount, isLoading, error };
}


export function useTotalInactiveUserCount() {
    const [inactiveUsersCount, setUserCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getUsersCount() {
            try {
                setIsLoading(true);
                const count = await fetchInactiveUsersCount();
                setUserCount(count);
            } catch (err) {
                console.error("Error fetching InActive User count: ", err);
                setError("Failed to fetch InActive Users Count");
            } finally {
                setIsLoading(false);
            }
        }

        getUsersCount();
    }, []);

    return { inactiveUsersCount, isLoading, error };
}

export function useUserPayslip(userId: string) {
    const [payslipCount, setPayslipCount] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getUserPayslipCount() {
            try {
                setIsLoading(true);
                const count = await fetchUserPayslipCount(userId);
                setPayslipCount(count);
            } catch (error) {
                console.error("Error fetching User Payslip Count: ", error);
                setError("Failed to fetch User Payslip Count");
            } finally {
                setIsLoading(false);
            }
        }
        getUserPayslipCount();
    }, [userId]);

    return { payslipCount, isLoading, error };
}

export function useUserBasicSalary(userId: string) {
    const [basicSalary, setBasicSalary] = useState<number | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function getUserPayslipCount() {
            try {
                setIsLoading(true);
                const count = await fetchUserBasicSalary(userId);
                setBasicSalary(count as number);
            } catch (error) {
                console.error("Error fetching User Basic Salary: ", error);
                setError("Failed to fetch Basic Salary Count");
            } finally {
                setIsLoading(false);
            }
        }
        getUserPayslipCount();
    }, [userId]);

    return { basicSalary, isLoading, error };
}
