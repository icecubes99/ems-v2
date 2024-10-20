"use client"
import { useCurrentUser } from '@/hooks/use-current-user';
import React, { use } from 'react'
import HomepageCards from '../_components/HomepageCards';
import { RoleGate } from '@/components/auth/role-gate';
import LayoutSideHead from '@/components/LayoutSideHead';
import HeadingTitle from '@/components/heading-title';


const HomePage = () => {
    const greeting = getGreeting()
    const user = useCurrentUser();

    return (
        <RoleGate allowedRoles={["USER", "ADMIN", "SUPERADMIN"]}>
            <LayoutSideHead>
                <HeadingTitle title={greeting + ", " + user?.firstName + "!"} />
                <HomepageCards />
            </LayoutSideHead>
        </RoleGate>
    )
}

export default HomePage

const getGreeting = () => {
    const currentHour = new Date().getHours();
    const currentMinutes = new Date().getMinutes();

    if (currentHour < 12) {
        return "🌅 Good Morning";
    } else if (currentHour === 12 && currentMinutes <= 59) {
        return "🍽️ Have a Happy Lunch";
    } else if (currentHour === 13 && currentMinutes === 0) {
        return "🍽️ Have a Happy Lunch";
    } else if (currentHour >= 17 && (currentHour > 17 || currentMinutes >= 30)) {
        return "🌒 Good Evening";
    } else {
        return "☀️ Good Afternoon";
    }
}