"use client"

import { fetchDepartmentSalaries, fetchPayrollSummary, fetchTopEarners, fetchYearlyPayrollData } from '@/data/fetch-data-dashboard';
import { useState, useEffect } from 'react'


type PayrollSummary = {
    _sum: {
        basicSalary: number | null;
        overtimeSalary: number | null;
        additionalEarnings: number | null;
        totalDeductions: number | null;
        netSalary: number | null;
    };
    _avg: {
        netSalary: number | null;
    };
    _count: {
        id: number;
    };
}

export function usePayrollSummary(payrollId: string) {
    const [summary, setSummary] = useState<PayrollSummary | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        async function fetchData() {
            if (!payrollId) {
                setIsLoading(false)
                return
            }

            setIsLoading(true)
            setError(null)

            try {
                const data = await fetchPayrollSummary(payrollId)
                setSummary(data as PayrollSummary)
            } catch (err) {
                setError(err instanceof Error ? err.message : 'An unknown error occurred')
            } finally {
                setIsLoading(false)
            }
        }

        fetchData()
    }, [payrollId])

    return { summary, isLoading, error }
}

export function useDepartmentSalaries(payrollId: string) {
    const [salaries, setSalaries] = useState<{ departmentName: string, totalSalary: number }[]>([])
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        async function fetchData() {
            try {
                const data = await fetchDepartmentSalaries(payrollId)
                setSalaries(data)
            } catch (err) {
                setError(err instanceof Error ? err.message : 'An unknown error occurred')
            } finally {
                setIsLoading(false)
            }
        }
        fetchData()
    }, [payrollId])

    return { salaries, isLoading, error }
}

type TopEarner = {
    user: { firstName: string | null; lastName: string | null };
    netSalary: number;
}

export function useTopEarners(payrollId: string, limit: number = 5) {
    const [topEarners, setTopEarners] = useState<TopEarner[]>([])
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        async function fetchData() {
            try {
                const data = await fetchTopEarners(payrollId, limit)
                setTopEarners(data)
            } catch (err) {
                setError(err instanceof Error ? err.message : 'An unknown error occurred')
            } finally {
                setIsLoading(false)
            }
        }
        fetchData()
    }, [payrollId, limit])

    return { topEarners, isLoading, error }
}


export type YearlyPayrollData = Awaited<ReturnType<typeof fetchYearlyPayrollData>>

export function useYearlyPayrollData(year: number) {
    const [yearlyData, setYearlyData] = useState<YearlyPayrollData | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        async function fetchData() {
            setIsLoading(true)
            setError(null)
            try {
                const data = await fetchYearlyPayrollData(year)
                setYearlyData(data)
            } catch (err) {
                setError(err instanceof Error ? err.message : 'An unknown error occurred')
            } finally {
                setIsLoading(false)
            }
        }

        fetchData()
    }, [year])

    return { yearlyData, isLoading, error }
}