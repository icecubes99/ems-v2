"use client"
import { useState, useEffect } from 'react'
import { fetchSalaryIncreaseEvents } from '@/data/fetch-salary-increase-events';
import { SalaryIncreaseEvent } from '@/types/types';


export function useSalaryIncreaseEvents() {
    const [salaryIncreaseEvents, setSalaryIncreaseEvent] = useState<SalaryIncreaseEvent[] | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const getSalaryIncreaseEvents = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchSalaryIncreaseEvents();

                if (result.error) {
                    setError(result.error);
                    setSalaryIncreaseEvent(null);
                } else {
                    setSalaryIncreaseEvent(result.salaryIncrease as SalaryIncreaseEvent[]);
                }

            } catch (error) {
                setError("An error occured while fetching data");
                console.error("Error fetching Salary Increase Events", error);
                setSalaryIncreaseEvent(null);
            } finally {
                setIsLoading(false);
            }
        };

        getSalaryIncreaseEvents();
    }, []);

    return { salaryIncreaseEvents, isLoading, error }
}