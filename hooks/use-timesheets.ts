// hooks/useTimesheets.ts
"use client"

import { useState, useEffect } from 'react';
import { fetchTimesheets, fetchTimesheetById } from '@/data/fetch-timesheets';
import { Timesheet } from '@prisma/client';

export function useTimesheets() {
    const [timesheets, setTimesheets] = useState<Timesheet[] | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const getTimesheets = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchTimesheets();

                if (result.error) {
                    setError(result.error);
                    setTimesheets(null);
                } else {
                    setTimesheets(result.timesheets as Timesheet[]);
                }
            } catch (error) {
                setError('An error occurred while fetching timesheets');
                setTimesheets(null);
                console.error('Error fetching timesheets:', error);
            } finally {
                setIsLoading(false);
            }
        };

        getTimesheets();
    }, []);

    return { timesheets, isLoading, error };
}

export function useTimesheet(timesheetId: string) {
    const [timesheet, setTimesheet] = useState<Timesheet | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const getTimesheet = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchTimesheetById(timesheetId);

                if (result.error) {
                    setError(result.error);
                    setTimesheet(null);
                } else {
                    setTimesheet(result.timesheet as Timesheet);
                }
            } catch (error) {
                setError('An error occurred while fetching the timesheet');
                setTimesheet(null);
                console.error('Error fetching timesheet:', error);
            } finally {
                setIsLoading(false);
            }
        };

        if (timesheetId) {
            getTimesheet();
        }
    }, [timesheetId]);

    return { timesheet, isLoading, error };
}