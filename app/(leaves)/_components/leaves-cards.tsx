"use client"
import { Calendar, PlusCircle } from 'lucide-react'
import React from 'react'
import useUser from '@/hooks/use-user'
import { useCurrentUserId } from '@/hooks/use-current-user'
import HeadingCard from '@/components/heading-card'

const LeavesCards = () => {

    const userId = useCurrentUserId();
    const { user, loading, error } = useUser(userId as string);
    const vacationDays = user?.vacationDays
    const incentiveDays = user?.incentiveDays
    return (


        <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6 ">

            <HeadingCard title='Vacation Days Available' count={vacationDays} icon={<Calendar />} isLoading={loading} />

            <HeadingCard title='Incentive Days Available' count={incentiveDays} icon={<Calendar />} isLoading={loading} />

            <HeadingCard title='Sick Days Available' count='UNLIMITED' icon={<Calendar />} isLoading={loading} />
        </div>

    )
}

export default LeavesCards