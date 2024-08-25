"use client"
import React from 'react'
import EmployeeDetails from '../_components/EmployeeDetails'
import LayoutSideHead from '@/components/LayoutSideHead'
import { useCurrentUser, useCurrentUserId } from '@/hooks/use-current-user'
import AddressCard from '../_components/_AddressComponents/AddressCard'
import EmergencyContactCard from '../_components/_EmergencyContactComponents/EmergencyContactCard'

const Page = () => {
    const user = useCurrentUser();
    const userId = useCurrentUserId() || "";

    return (
        <LayoutSideHead label='My Profile'>
            <EmployeeDetails user={user}>
                <AddressCard userId={userId} />
                <EmergencyContactCard userId={userId} />
            </EmployeeDetails>
        </LayoutSideHead>
    )
}

export default Page