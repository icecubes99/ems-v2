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
import { SalaryHistoryDisplay } from './_components/salary-history'
import useUser from '@/hooks/use-user'
import { useCurrentUser } from '@/hooks/use-current-user'

const page = () => {
    const { payslips } = useOwnPayslips()
    const user = useCurrentUser();
    return (
        <LayoutSideHead>
            <div className='flex flex-col'>

                <div className='mt-5 justify-between flex flex-row  '>
                    <p className='font-bold text-4xl'>PAYSLIPS MANAGEMENT</p>
                </div>

                <div className='grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-4 mt-5 justify-center'>

                    <div className='col-span-12 lg:col-span-9 w-full'>
                        <PayslipCards className='' />
                    </div>

                    <div className='col-span-12 lg:col-span-3 lg:row-span-3'>
                        <SalaryHistoryDisplay userId={user?.id || ""} />
                    </div>

                    <TableWrapper title='Payslips History' description='View your history of payslips' icon={<PhilippinePesoIcon />} className='col-span-9 mt-0'>
                        <DataTablePayslips columns={columnsPayslips} data={payslips || []} />
                    </TableWrapper>

                </div>


            </div>
        </LayoutSideHead>
    )
}

export default page