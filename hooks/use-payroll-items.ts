"use client"
import { useState, useEffect, useCallback } from 'react'
import { fetchPayrollItems } from '@/data/fetch-payroll-items'
import { PayrollItemWithUser } from '@/types/types';

export function usePayrollItems(payrollId: string) {
    const [payrollItems, setPayrollItems] = useState<PayrollItemWithUser[] | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const getPayrollItems = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchPayrollItems(payrollId);

                if (result.error) {
                    setError(result.error);
                    setPayrollItems(null);
                } else {
                    setPayrollItems(result.payrollItems as PayrollItemWithUser[]);
                }

            } catch (error) {
                setError("An error occured while fetching data");
                console.error("Error fetching Payroll Items", error);
                setPayrollItems(null);
            } finally {
                setIsLoading(false);
            }
        };

        getPayrollItems();
    }, [payrollId]);

    return { payrollItems, isLoading, error }
}