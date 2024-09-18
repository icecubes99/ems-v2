"use client"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Briefcase, Building, CalendarClock, UserCheck, UserPlus, Users, UserX } from "lucide-react"
import { useTotalActiveUserCount, useTotalDepartmentsCount, useTotalDesignationCount, useTotalInactiveUserCount, useTotalUserCount } from "@/hooks/use-ModelCounts"
import Link from "next/link"

const EmployeeCards = () => {
    const { userCount, error, isLoading } = useTotalUserCount()
    const { activeUsersCount } = useTotalActiveUserCount()
    const { inactiveUsersCount } = useTotalInactiveUserCount()

    return (
        <>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6 ">
                <Card className="hover:shadow-xl transition-shadow duration-300">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Total Employees
                        </CardTitle>
                        <Users className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{userCount}</div>
                    </CardContent>
                </Card>

                <Card className="hover:shadow-xl transition-shadow duration-300">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Active Employees
                        </CardTitle>
                        <UserCheck className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{activeUsersCount}</div>
                    </CardContent>
                </Card>

                <Card className="hover:shadow-xl transition-shadow duration-300">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Inactive Employees
                        </CardTitle>
                        <UserX className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{inactiveUsersCount}</div>
                    </CardContent>
                </Card>
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