"use client"

import { useState, useEffect, useCallback } from 'react'
import { fetchOwnPayslips, fetchOtherPayslips } from '@/data/fetch-own-payslips'
import { Payroll, PayrollItem } from '@prisma/client'
import { PayrollItemWithUser } from '@/types/types';

export function useOwnPayslips() {
    const [payslips, setPayslips] = useState<PayrollItemWithUser[] | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchPayslips = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchOwnPayslips();

                if (result.error) {
                    setError(result.error);
                    setPayslips(null);
                } else {
                    setPayslips(result.payslips as PayrollItemWithUser[]);
                }

            } catch (error) {
                setError("An error occured while fetching data");
                console.error("Error fetching Payslips", error);
                setPayslips(null);
            } finally {
                setIsLoading(false);
            }
        };

        fetchPayslips();
    }, []);

    return { payslips, isLoading, error }
}


export function useOtherPayslips(userId: string) {
    const [payslips, setPayslips] = useState<PayrollItem[] | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchPayslips = async () => {
            setIsLoading(true);
            setError(null);

            try {
                const result = await fetchOtherPayslips(userId);

                if (result.error) {
                    setError(result.error);
                    setPayslips(null);
                } else {
                    setPayslips(result.payslips as PayrollItem[]);
                }

            } catch (error) {
                setError("An error occured while fetching data");
                console.error("Error fetching Payslips", error);
                setPayslips(null);
            } finally {
                setIsLoading(false);
            }
        };

        fetchPayslips();
    }, []);

    return { payslips, isLoading, error }
}

