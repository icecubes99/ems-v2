"use client"
import { Calendar, PlusCircle } from 'lucide-react'
import React from 'react'
import useUser from '@/hooks/use-user'
import { useCurrentUserId } from '@/hooks/use-current-user'

const LeavesCards = () => {

    const userId = useCurrentUserId();
    const { user, loading, error } = useUser(userId as string);
    const vacationDays = user?.vacationDays
    const incentiveDays = user?.incentiveDays
    return (


        <div className='grid grid-cols-3 gap-10 pr-6'>
            <div className="flex items-center px-5 py-6 bg-white rounded-xl border bg-card text-card-foreground shadow  hover:shadow-xl transition-shadow duration-300">
                <div className="p-3 rounded-full bg-violet-900 ">
                    <Calendar className="h-8 w-8 text-white" />
                </div>
                <div className="mx-5">
                    {
                        loading ? <p>Loading...</p> :
                            error ? <p>Error</p> :
                                <h4 className="text-2xl font-semibold text-gray-700">{vacationDays}</h4>
                    }
                    <div className="text-gray-500">Vacation Days Available</div>
                </div>
            </div>

            <div className="flex items-center px-5 py-6 bg-white rounded-xl border bg-card text-card-foreground shadow  hover:shadow-xl transition-shadow duration-300">
                <div className="p-3 rounded-full bg-violet-900 ">
                    <Calendar className="h-8 w-8 text-white" />
                </div>
                <div className="mx-5">
                    {
                        loading ? <p>Loading...</p> :
                            error ? <p>Error</p> :
                                <h4 className="text-2xl font-semibold text-gray-700">{incentiveDays}</h4>
                    }
                    <div className="text-gray-500">Incentive Days Available</div>
                </div>
            </div>

            <div className="flex items-center px-5 py-6 bg-white rounded-xl border bg-card text-card-foreground shadow  hover:shadow-lg transition-shadow duration-300">
                <div className="p-3 rounded-full bg-violet-900 ">
                    <Calendar className="h-8 w-8 text-white" />
                </div>
                <div className="mx-5">
                    <h4 className="text-2xl font-semibold text-gray-700">UNLIMITED</h4>
                    <div className="text-gray-500">Sick and Maternity Days</div>
                </div>
            </div>
        </div>

    )
}

export default LeavesCards