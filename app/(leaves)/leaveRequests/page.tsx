import LayoutSideHead from '@/components/LayoutSideHead'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import { Calendar, PlusCircle } from 'lucide-react'
import React from 'react'
import OwnLeavesTable from '../_components/own-leaves-table'
import { Button } from '@/components/ui/button'
import RequestLeaveForm from '@/components/request-leave-form'
import LeavesCards from '../_components/leaves-cards'


const page = () => {
    return (
        <LayoutSideHead label='Leave Requests'>
            <div className='flex flex-col gap-6'>

                <div className='mt-5'>
                    <p className='font-bold text-4xl'>LEAVE MANAGEMENT</p>
                </div>

                <LeavesCards />

                <div className='grid grid-cols-3 gap-10 pr-6'>
                    <div className='col-span-3'>
                        <div className="flex justify-between items-center mb-2">
                            <h4 className="text-xl font-semibold text-gray-700">Leave Requests History</h4>
                            <RequestLeaveForm />
                        </div>
                        <OwnLeavesTable classname="w-full" />
                    </div>
                </div>

            </div>
        </LayoutSideHead>
    )
}

export default page