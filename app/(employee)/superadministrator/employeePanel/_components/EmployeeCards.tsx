"use client"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Briefcase, Building, CalendarClock, UserCheck, UserPlus, Users, UserX } from "lucide-react"
import { useTotalActiveUserCount, useTotalDepartmentsCount, useTotalDesignationCount, useTotalInactiveUserCount, useTotalUserCount } from "@/hooks/use-ModelCounts"
import Link from "next/link"
import HeadingCard from "@/components/heading-card"

const EmployeeCards = () => {
    const { userCount, error, isLoading } = useTotalUserCount()
    const { activeUsersCount, isLoading: auLoad } = useTotalActiveUserCount()
    const { inactiveUsersCount, isLoading: iuLoad } = useTotalInactiveUserCount()

    return (
        <>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6 ">

                <HeadingCard title="Total Employees" count={userCount} icon={<Users />} isLoading={isLoading} />

                <HeadingCard title="Active Employees" count={activeUsersCount} icon={<UserCheck />} isLoading={auLoad} />

                <HeadingCard title="Inactive Employees" count={inactiveUsersCount} icon={<UserX />} isLoading={iuLoad} />
            </div>

            <p className="col-span-4 font-bold  text-lg">QUICK ACTIONS</p>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6">
                <Link href={"/superadministrator/employeePanel/createEmployee"} className="col-span-2">
                    <Button variant={"superadmin"} className='w-full' size={"lg"}>
                        <UserPlus className="h-4 w-4 mr-4" />
                        Create Employee
                    </Button>
                </Link>
                <Button variant={"outline"} size={"lg"}>View Employees</Button>
                <Button variant={"outline"} size={"lg"}>Add Allowance to Employees</Button>
            </div>
        </>
    )
}

export default EmployeeCards