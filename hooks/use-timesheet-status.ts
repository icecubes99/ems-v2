// hooks/useTimesheetStatus.ts
import { useState, useEffect } from 'react';
import { getTimesheetStatus } from '@/actions/get-timesheet-status';

export type TimesheetStatus = 'NOT_CLOCKED_IN' | 'CLOCKED_IN' | 'CLOCKED_OUT';

export function useTimesheetStatus() {
    const [status, setStatus] = useState<TimesheetStatus>('NOT_CLOCKED_IN');
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        const fetchStatus = async () => {
            try {
                const result = await getTimesheetStatus();
                setStatus(result.status);
            } catch (error) {
                console.error('Failed to fetch timesheet status:', error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchStatus();
    }, []);

    const refreshStatus = async () => {
        setIsLoading(true);
        try {
            const result = await getTimesheetStatus();
            setStatus(result.status);
        } catch (error) {
            console.error('Failed to refresh timesheet status:', error);
        } finally {
            setIsLoading(false);
        }
    };

    return { status, isLoading, refreshStatus };
}