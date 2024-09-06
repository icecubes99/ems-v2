import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Briefcase, Building, Users } from "lucide-react"
import { useTotalDepartmentsCount, useTotalDesignationCount, useTotalUserCount } from "@/hooks/use-ModelCounts"

const HomepageCards = () => {
    const { userCount, error, isLoading } = useTotalUserCount()
    const { departmentCount } = useTotalDepartmentsCount()
    const { designationCount } = useTotalDesignationCount()

    // if (error) return <div>{error.message}</div>


    return (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 mr-6">
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
    )
}

export default HomepageCards
