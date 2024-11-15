"use client"
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import { FaMoneyBillWaveAlt } from 'react-icons/fa'
import { DataTablePayslips } from './_components/data-table-payslips'
import { columnsPayslips } from './_components/columns-payslips'
import { useOwnPayslips } from '@/hooks/use-payslips'
import PayslipCards from './_components/payslip-cards'
import TableWrapper from '@/components/table-wrapper'
import { PhilippinePesoIcon } from 'lucide-react'

const page = () => {
    const { payslips } = useOwnPayslips()
    return (
        <LayoutSideHead>
            <div className='flex flex-col'>

                <div className='mt-5 justify-between flex flex-row  '>
                    <p className='font-bold text-4xl'>PAYSLIPS MANAGEMENT</p>
                </div>

                <PayslipCards />
                <div className='grid grid-cols-12 gap-4 '>
                    <TableWrapper title='Payslips History' description='View your history of payslips' icon={<PhilippinePesoIcon />} className='col-span-9'>
                        <DataTablePayslips columns={columnsPayslips} data={payslips || []} />
                    </TableWrapper>


                    <div className='col-span-3 row-span-3'>
                        <div className='border border-b p-6'>
                            HISTORY
                        </div>
                    </div>
                </div>


            </div>
        </LayoutSideHead>
    )
}

export default page