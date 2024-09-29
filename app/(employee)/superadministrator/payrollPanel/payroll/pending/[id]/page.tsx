"use client"
import { DataTableRemainingLeaves } from '@/app/(leaves)/_components/DataTableRemainingLeaves'
import { RoleGate } from '@/components/auth/role-gate'
import HeadingTitle from '@/components/heading-title'
import LayoutSideHead from '@/components/LayoutSideHead'
import { usePayrollItems } from '@/hooks/use-payroll-items'
import React from 'react'
import { columnsPayrollItems } from '../../../_components/columns-payroll-items'
import { usePayroll } from '@/hooks/use-payroll-data'
import { Badge } from '@/components/ui/badge'
import { DataTableWithFooter } from '@/components/data-table-with-footer'
import { Calendar, DollarSign } from 'lucide-react'
import { Button } from '@/components/ui/button'

const page = ({ params }: { params: { id: string } }) => {
    const { payrollItems } = usePayrollItems(params.id)
    const { payroll, isLoading } = usePayroll(params.id)

    const formatCurrency = (amount: number) => {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'PHP',
            minimumFractionDigits: 2,
            maximumFractionDigits: 2,
        }).format(amount);
    };

    const totalAmount = formatCurrency(payroll?.totalAmount || 0)

    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead label='Payroll'>
                <HeadingTitle title={`Payroll #${params.id}`} />
                <TableWrapper
                    title='Payroll Details'
                    description='Wow'
                    payPeriodStart={payroll?.payPeriodStart.toDateString()}
                    payPeriodEnd={payroll?.payPeriodEnd.toDateString()}
                    totalAmount={totalAmount}
                >
                    <DataTableWithFooter
                        columns={columnsPayrollItems}
                        data={payrollItems || []}

                    />
                </TableWrapper>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page

interface TableWrapperProps {
    title: string
    description: string
    children: React.ReactNode
    icon?: React.ReactNode
    payPeriodStart?: string
    payPeriodEnd?: string
    createdAt?: string
    totalAmount?: number | string
}

function TableWrapper({ title, description, children, icon, payPeriodStart, payPeriodEnd, totalAmount }: TableWrapperProps) {
    return (
        <div className='bg-card rounded-xl border border-white shadow-md mr-6 mt-5 hover:shadow-lg transition duration-300 '>
            <div className='grid grid-cols-4 border-b border-border'>

                <div className='p-6  col-span-3'>
                    <h2 className='text-2xl font-semibold flex items-center gap-2 mb-2'>
                        {icon && React.cloneElement(icon as React.ReactElement, { className: "h-6 w-6 text-primary" })}
                        {title}
                    </h2>

                    <div className='flex flex-col w-[500px] text-gray-600'>
                        <div className='flex flex-row justify-between'>
                            <span className=' '>
                                Status:
                            </span>
                            <Badge variant={"outline"} className='text-center flex justify-center '>
                                PENDING
                            </Badge>
                        </div>

                        <div className='grid grid-cols-2'>
                            <div className='flex items-center gap-2'>
                                <Calendar className='h-4 w-4 text-muted-foreground' />
                                Pay Period Start:
                            </div>
                            <span className='flex justify-end text-right'>
                                {payPeriodStart}
                            </span>
                        </div>

                        <div className='grid grid-cols-2'>
                            <div className='flex items-center gap-2'>
                                <Calendar className='h-4 w-4 text-muted-foreground' />
                                Pay Period End:
                            </div>
                            <span className='flex justify-end text-right'>
                                {payPeriodEnd}
                            </span>
                        </div>

                        <div className='grid grid-cols-2'>
                            <div className='flex items-center gap-2'>
                                <DollarSign className='h-4 w-4 text-muted-foreground' />
                                Total Amount:
                            </div>
                            <span className='flex justify-end text-right'>
                                {`${totalAmount}`}
                            </span>
                        </div>
                    </div>
                </div>

                <div className='flex items-center justify-center '>
                    <Button variant={"success"} size={"lg"}>
                        Approve Payroll
                    </Button>
                </div>
            </div>
            <div className='p-6'>
                {children}
            </div>

        </div>
    )
}