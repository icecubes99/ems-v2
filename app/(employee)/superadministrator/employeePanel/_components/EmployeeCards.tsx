"use client"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Briefcase, Building, CalendarClock, CircleDollarSign, Plus, UserCheck, UserPlus, Users, UserX } from "lucide-react"
import { useTotalActiveUserCount, useTotalDepartmentsCount, useTotalDesignationCount, useTotalInactiveUserCount, useTotalUserCount } from "@/hooks/use-ModelCounts"
import Link from "next/link"
import HeadingCard from "@/components/heading-card"
import { MagnifyingGlassIcon } from "@radix-ui/react-icons"
import CreateAllowances from "../../payrollPanel/_components/create-allowances-form"
import QuickActions from "@/components/quick-actions"
import { ArchivedUsersDialog } from "./archived-users-dialog"

const EmployeeCards = () => {
    const { userCount, error, isLoading } = useTotalUserCount()
    const { activeUsersCount, isLoading: auLoad } = useTotalActiveUserCount()
    const { inactiveUsersCount, isLoading: iuLoad } = useTotalInactiveUserCount()

    return (
        <>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5   ">

                <HeadingCard title="Total Employees" count={userCount} icon={<Users />} isLoading={isLoading} />

                <HeadingCard title="Active Employees" count={activeUsersCount} icon={<UserCheck />} isLoading={auLoad} />

                <HeadingCard title="Inactive Employees" count={inactiveUsersCount} icon={<UserX />} isLoading={iuLoad} />
            </div>

            <p className="col-span-4 font-bold  text-lg">QUICK ACTIONS</p>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3 mb-8 mt-5  ">
                <Link href={"/superadministrator/employeePanel/createEmployee"} className="">
                    <Button variant="superadmin" className="h-auto py-4 flex w-full flex-col items-center justify-center">
                        <UserPlus className="h-6 w-6 mb-2" />
                        Add Employees
                    </Button>
                </Link>
                <CreateAllowances />
            </div>


            <QuickActions title='ADVANCED' className='lg:grid-cols-4'>
                <Link href={"/superadministrator/employeePanel/allowancesPanel"}>
                    <Button className="w-full">
                        Manage Allowances
                    </Button>
                </Link>

                <ArchivedUsersDialog />
            </QuickActions>
        </>
    )
}

export default EmployeeCards