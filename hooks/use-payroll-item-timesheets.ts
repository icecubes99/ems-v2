"use client"

import { useState, useEffect } from 'react'
import { fetchPayrollItemTimesheets } from '@/data/fetch-payroll-item-timesheets'
import { Timesheet } from '@prisma/client'

export function usePayrollItemTimesheets(payrollItemId: string) {
    const [timesheets, setTimesheets] = useState<Timesheet[] | null>(null)
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const getTimesheets = async () => {
            setIsLoading(true)
            setError(null)

            try {
                const result = await fetchPayrollItemTimesheets(payrollItemId)

                if (result.error) {
                    setError(result.error)
                    setTimesheets(null)
                } else {
                    setTimesheets(result.payrollItemTimesheets ?? null)
                }
            } catch (error) {
                setError("An error occurred while fetching data")
                console.error("Error fetching Payroll Item Timesheets:", error)
                setTimesheets(null)
            } finally {
                setIsLoading(false)
            }
        }

        getTimesheets()
    }, [payrollItemId])

    return { timesheets, isLoading, error }
}