"use client"
import { useApprovedPayrollCount, useRejectedPayrollCount, useTotalApprovedPayslipCount, useTotalPayrollCount } from '@/hooks/use-ModelCounts'
import React from 'react'
import { IoDocument, IoSendSharp } from 'react-icons/io5';
import { RiMailSendFill } from "react-icons/ri";
import HeadingCard from '@/components/heading-card';
import { MdOutlinePayments } from "react-icons/md";

const PayrollPanelCards = () => {

    const { payrollCount, isLoading } = useTotalPayrollCount();
    const { payrollCount: approvedPC, isLoading: approvedIS } = useApprovedPayrollCount()
    const { payrollCount: rejectedPC, isLoading: rejectedIS } = useRejectedPayrollCount()
    const { payslipCount, isLoading: isLoadingPayslips } = useTotalApprovedPayslipCount()

    return (
        <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-3 mt-5   ">
            <HeadingCard title='Total Payroll Generated' count={payrollCount} icon={<MdOutlinePayments />} isLoading={isLoading} />
            <HeadingCard title='Total Payroll Approved' count={approvedPC} icon={<IoSendSharp />} isLoading={approvedIS} />
            <HeadingCard title='Total Payroll Rejected' count={rejectedPC} icon={<IoSendSharp />} isLoading={rejectedIS} />
            <HeadingCard title='Total Payslips Approved' count={payslipCount} icon={<RiMailSendFill />} isLoading={isLoadingPayslips} />
        </div>
    )
}

export default PayrollPanelCards
