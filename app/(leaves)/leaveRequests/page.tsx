import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import OwnLeavesTable from '../_components/own-leaves-table'
import RequestLeaveButton from '@/components/request-leave-form'
import LeavesCards from '../_components/leaves-cards'
import HeadingTitle from '@/components/heading-title'
import { StopwatchIcon } from '@radix-ui/react-icons'



const page = () => {
    return (
        <LayoutSideHead>
            <div className='flex flex-col'>

                <HeadingTitle title='LEAVE MANAGEMENT'>
                    <RequestLeaveButton />
                </HeadingTitle>

                <LeavesCards />
                <div className='bg-card  rounded-xl shadow  '>
                    <div className='p-6 border-b border-border'>
                        <h2 className='text-2xl font-semibold flex items-center gap-2'>
                            <StopwatchIcon className='h-6 w-6 text-primary' />
                            Leave Requests History
                        </h2>
                        <p className='text-muted-foreground mt-1'>View your past and current leave requests</p>
                    </div>
                    <div className='p-6'>
                        <OwnLeavesTable />
                    </div>
                </div>

            </div>
        </LayoutSideHead>
    )
}

export default page