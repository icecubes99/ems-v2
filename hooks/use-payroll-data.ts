"use client"

import { useState, useEffect } from 'react'
import { PayrollWithPayrollItems } from '@/types/types'
import { fetchPendingPayroll, fetchApprovedDeniedPayroll, fetchPayroll } from '@/data/fetch-payroll-data'

export function usePendingPayroll() {
    const [payroll, setPayroll] = useState<PayrollWithPayrollItems[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchPayroll = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchPendingPayroll()

                if (result.error) {
                    setError(result.error)
                    setPayroll(null)
                } else {
                    setPayroll(result.payroll as PayrollWithPayrollItems[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching payroll:', error)
                setPayroll(null)
            } finally {
                setIsLoading(false)
            }
        }

        fetchPayroll()
    }, [])

    return { payroll, isLoading, error }
}

export function useApprovedDeniedPayroll() {
    const [payroll, setPayroll] = useState<PayrollWithPayrollItems[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchPayroll = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchApprovedDeniedPayroll()

                if (result.error) {
                    setError(result.error)
                    setPayroll(null)
                } else {
                    setPayroll(result.payroll as PayrollWithPayrollItems[])
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching payroll:', error)
                setPayroll(null)
            } finally {
                setIsLoading(false)
            }
        }

        fetchPayroll()
    }, [])

    return { payroll, isLoading, error }
}

export function usePayroll(payrollId: string) {
    const [payroll, setPayroll] = useState<PayrollWithPayrollItems | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)


    useEffect(() => {
        const getPayroll = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchPayroll(payrollId)

                if (result.error) {
                    setError(result.error)
                    setPayroll(null)
                } else {
                    setPayroll(result.payroll as PayrollWithPayrollItems)
                }
            } catch (error) {
                setError('An error occurred while fetching data')
                console.error('Error fetching payroll:', error)
                setPayroll(null)
            } finally {
                setIsLoading(false)
            }
        }

        getPayroll()
    }, [])

    return { payroll, isLoading, error }
}