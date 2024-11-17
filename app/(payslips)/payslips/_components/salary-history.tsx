// components/salary-history-display.tsx
"use client"

import { useSalaryHistory } from '@/hooks/use-salary'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'
import { format } from 'date-fns'
import { formatPeso } from '@/lib/format'

interface SalaryHistoryDisplayProps {
    userId: string
}

interface SalaryHistory {
    id: string
    userId: string
    previousSalary: number
    newSalary: number
    endDate: Date
    reason: string
    basicSalary: number
    grossSalary: number
    user: {
        firstName: string | null
        lastName: string | null
    }
}
export function SalaryHistoryDisplay({ userId }: SalaryHistoryDisplayProps) {
    const { salaryHistories, currentSalary, isLoading, error } = useSalaryHistory(userId)

    if (isLoading) {
        return (
            <div className="space-y-4">
                <Skeleton className="h-[200px] w-full" />
                <Skeleton className="h-[400px] w-full" />
            </div>
        )
    }

    if (error) {
        return (
            <div className="p-4 text-red-500">
                {error}
            </div>
        )
    }
    const getAmountChangeColor = (amount: number | null) => {
        if (!amount) return "text-muted-foreground";
        return amount > 0 ? "text-green-600" : "text-red-600";
    };

    const formatAmountChange = (amount: number | null) => {
        if (!amount) return "";
        const sign = amount > 0 ? "+" : "−"; // Using minus sign (−) instead of hyphen (-)
        return `${sign}${formatPeso(Math.abs(amount))}`;
    };

    return (
        <div className="max-h-[800px] overflow-y-auto pr-2 space-y-6 mt-5">
            <Card>
                <CardHeader>
                    <CardTitle>Current Salary Information</CardTitle>
                </CardHeader>
                <CardContent>
                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <p className="text-sm font-medium text-muted-foreground">Basic Salary</p>
                            <p className="text-lg font-bold">
                                {currentSalary?.basicSalary ? formatPeso(currentSalary.basicSalary) : '—'}
                            </p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-muted-foreground">Gross Salary</p>
                            <p className="text-lg font-bold">
                                {currentSalary?.grossSalary ? formatPeso(currentSalary.grossSalary) : '—'}
                            </p>
                        </div>
                    </div>
                </CardContent>
            </Card>

            <Card>
                <CardHeader>
                    <CardTitle>Salary History</CardTitle>
                </CardHeader>
                <CardContent>
                    <div className="space-y-4">
                        {salaryHistories?.map((history) => (
                            <div
                                key={history.id}
                                className="border-b pb-4"
                            >
                                <div className="grid grid-cols-2 gap-4">
                                    <div>
                                        <p className="text-sm font-medium text-muted-foreground">Previous Salary</p>
                                        <p className="text-md font-semibold">{formatPeso(history.grossSalary)}</p>
                                    </div>
                                    <div>
                                    </div>
                                    <div>
                                        <p className="text-sm font-medium text-muted-foreground">Date</p>
                                        <p className="text-md font-semibold">
                                            {format(new Date(history.endDate), 'MMM dd, yyyy')}
                                        </p>
                                    </div>
                                    <div>
                                        <p className="text-sm font-medium text-muted-foreground">Type</p>
                                        <p className="text-md font-semibold">
                                            {history.salaryIncreaseEventId ?
                                                (history.amountIncreased && history.amountIncreased > 0 ?
                                                    'Salary Increase' : 'Salary Decrease')
                                                : '---'}
                                        </p>
                                    </div>
                                    {history.amountIncreased !== null && (
                                        <div>
                                            <p className="text-sm font-medium text-muted-foreground">Amount Changed</p>
                                            <p className={`text-md font-semibold ${getAmountChangeColor(history.amountIncreased)}`}>
                                                {formatAmountChange(history.amountIncreased)}
                                            </p>
                                        </div>
                                    )}
                                </div>
                            </div>
                        ))}
                        {!salaryHistories?.length && (
                            <p className="text-center text-muted-foreground">No salary history found</p>
                        )}
                    </div>
                </CardContent>
            </Card>
        </div>
    )
}