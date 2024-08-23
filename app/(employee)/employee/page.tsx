"use client"
import React from 'react'
import EmployeeDetails from '../_components/EmployeeDetails'
import LayoutSideHead from '@/components/LayoutSideHead'
import { useCurrentUser, useCurrentUserId } from '@/hooks/use-current-user'
import AddAddressButton from '../_components/AddAddressButton'
import AddressForm from '@/components/AddressForm'
import useUserAddress from '@/hooks/use-current-address'
import AddressCard from '../_components/AddressCard'

const Page = () => {
    const user = useCurrentUser();
    const userId = useCurrentUserId() || "";

    return (
        <LayoutSideHead label='My Profile'>
            <EmployeeDetails user={user}>
                <AddressCard userId={userId} />
            </EmployeeDetails>
        </LayoutSideHead>
    )
}

export default Page