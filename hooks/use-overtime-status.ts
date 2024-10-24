// hooks/use-overtime-status.ts
import { useState, useEffect } from 'react';
import { getOvertimeStatus } from '@/data/fetch-overtime-status';

export type OvertimeStatus = 'NOT_RECORDED' | 'IN_PROGRESS' | 'COMPLETED';

export function useOvertimeStatus() {
    const [status, setStatus] = useState<OvertimeStatus>('NOT_RECORDED');
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        const fetchStatus = async () => {
            try {
                const result = await getOvertimeStatus();
                setStatus(result.status);
            } catch (error) {
                console.error('Failed to fetch overtime status:', error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchStatus();
    }, []);

    const refreshStatus = async () => {
        setIsLoading(true);
        try {
            const result = await getOvertimeStatus();
            setStatus(result.status);
        } catch (error) {
            console.error('Failed to refresh overtime status:', error);
        } finally {
            setIsLoading(false);
        }
    };

    return { status, isLoading, refreshStatus };
}