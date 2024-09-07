import LayoutSideHead from '@/components/LayoutSideHead'
import LayoutSideHeadServer from '@/components/LayoutSideHeadServer'
import RequestLeaveForm from '@/components/request-leave-form'
import React from 'react'

const page = () => {
    return (
        <LayoutSideHead label='Payslips'>
            <div>Wala pay Unod

                <div>
                    <RequestLeaveForm />
                </div>
            </div>
        </LayoutSideHead>
    )
}

export default page