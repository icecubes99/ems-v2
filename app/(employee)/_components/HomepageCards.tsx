import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Briefcase, Building, CalendarClock, Users } from "lucide-react"
import { useTotalDepartmentsCount, useTotalDesignationCount, useTotalUserCount } from "@/hooks/use-ModelCounts"
import { HolidayTable } from "@/components/holidays-table"
import { TimesheetDialog } from "@/components/Timesheet"


const HomepageCards = () => {
    const { userCount, error, isLoading } = useTotalUserCount()
    const { departmentCount } = useTotalDepartmentsCount()
    const { designationCount } = useTotalDesignationCount()

    // if (error) return <div>{error.message}</div>


    return (
        <>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6 ">
                <Card>
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

                <Card>
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Departments
                        </CardTitle>
                        <Building className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{departmentCount}</div>
                    </CardContent>
                </Card>

                <Card>
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Designations
                        </CardTitle>
                        <Briefcase className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{designationCount}</div>
                    </CardContent>
                </Card>

                <Card>
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                        <CardTitle>
                            Documents
                        </CardTitle>
                        <Users className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">100</div>
                    </CardContent>
                </Card>


            </div>
            <p className="col-span-4 font-bold  text-lg">QUICK ACTIONS</p>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6">
                <TimesheetDialog classname="col-span-2" />
                <Button variant={"auth"} size={"lg"}>Upload Documents</Button>
                <Button variant={"auth"} size={"lg"}>Record Overtime</Button>
            </div>


            <p className="col-span-4 font-bold  text-lg">MISC</p>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6">
                <HolidayTable className="col-span-2" />
            </div>
        </>
    )
}

export default HomepageCards
