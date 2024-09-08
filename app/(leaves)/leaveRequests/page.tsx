import LayoutSideHead from '@/components/LayoutSideHead'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import { Calendar, PlusCircle } from 'lucide-react'
import React from 'react'
import OwnLeavesTable from '../_components/own-leaves-table'
import { Button } from '@/components/ui/button'
import RequestLeaveForm from '@/components/request-leave-form'


const page = () => {
    return (
        <LayoutSideHead label='Leave Requests'>
            <div className='flex flex-col gap-6'>

                <div className='mt-5'>
                    <p className='font-bold text-4xl'>LEAVE MANAGEMENT</p>
                </div>

                <div className='grid grid-cols-3 gap-10 pr-6'>
                    <div className="flex items-center px-5 py-6 bg-white rounded-xl border bg-card text-card-foreground shadow">
                        <div className="p-3 rounded-full bg-violet-900 ">
                            <Calendar className="h-8 w-8 text-white" />
                        </div>
                        <div className="mx-5">
                            <h4 className="text-2xl font-semibold text-gray-700">100</h4>
                            <div className="text-gray-500">Vacation Days Available</div>
                        </div>
                    </div>

                    <div className="flex items-center px-5 py-6 bg-white rounded-xl border bg-card text-card-foreground shadow">
                        <div className="p-3 rounded-full bg-violet-900 ">
                            <Calendar className="h-8 w-8 text-white" />
                        </div>
                        <div className="mx-5">
                            <h4 className="text-2xl font-semibold text-gray-700">100</h4>
                            <div className="text-gray-500">Vacation Days Available</div>
                        </div>
                    </div>

                    <div className="flex items-center px-5 py-6 bg-white rounded-xl border bg-card text-card-foreground shadow">
                        <div className="p-3 rounded-full bg-violet-900 ">
                            <Calendar className="h-8 w-8 text-white" />
                        </div>
                        <div className="mx-5">
                            <h4 className="text-2xl font-semibold text-gray-700">100</h4>
                            <div className="text-gray-500">Vacation Days Available</div>
                        </div>
                    </div>


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