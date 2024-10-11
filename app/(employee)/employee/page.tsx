"use client"
import React from 'react'
import EmployeeDetails from '../_components/EmployeeDetails'
import LayoutSideHead from '@/components/LayoutSideHead'
import { useCurrentUser, useCurrentUserId } from '@/hooks/use-current-user'
import AddressCard from '../_components/_AddressComponents/AddressCard'
import EmergencyContactCard from '../_components/_EmergencyContactComponents/EmergencyContactCard'
import useUserAssignment from '@/hooks/use-current-assignment'
import useDesignation from '@/hooks/use-designation'
import QuickActions from '@/components/quick-actions'
import UploadProfilePicture from '../_components/profile-picture'
import { useUserImage } from '@/hooks/use-user-image'

const Page = () => {
    const user = useCurrentUser();
    const userId = useCurrentUserId() as string;
    const { userImage } = useUserImage();

    return (
        <LayoutSideHead label='My Profile'>

            <EmployeeDetails>
                <AddressCard userId={userId} />
                <EmergencyContactCard userId={userId} />
            </EmployeeDetails>

            <QuickActions>
                <UploadProfilePicture userId={userId} initialProfilePicture={userImage || undefined} />
            </QuickActions>
        </LayoutSideHead>
    )
}

export default Page