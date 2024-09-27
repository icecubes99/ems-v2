"use client"
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import { FaMoneyBillWaveAlt } from 'react-icons/fa'
import { DataTablePayslips } from './_components/data-table-payslips'
import { columnsPayslips } from './_components/columns-payslips'
import { useOwnPayslips } from '@/hooks/use-payslips'
import PayslipCards from './_components/payslip-cards'

const page = () => {
    const { payslips } = useOwnPayslips()
    return (
        <LayoutSideHead label='Payslips'>
            <div className='flex flex-col'>

                <div className='mt-5 justify-between flex flex-row mr-6'>
                    <p className='font-bold text-4xl'>PAYSLIPS MANAGEMENT</p>
                </div>

                <PayslipCards />
                <div className='bg-card  rounded-xl shadow mr-6'>
                    <div className='p-6 border-b border-border'>
                        <h2 className='text-2xl font-semibold flex items-center gap-2'>
                            <FaMoneyBillWaveAlt className='h-6 w-6 text-primary' />
                            Payslips History
                        </h2>
                        <p className='text-muted-foreground mt-1'>View your past and current payslips</p>
                    </div>
                    <div className='p-6'>
                        <DataTablePayslips columns={columnsPayslips} data={payslips || []} />
                    </div>
                </div>

            </div>
        </LayoutSideHead>
    )
}

export default page