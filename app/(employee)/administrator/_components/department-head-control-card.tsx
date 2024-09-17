import { useUserDepartmentHead } from "@/hooks/use-user-department-head";
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Skeleton } from "@/components/ui/skeleton"
import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import ViewDepartment from "./view-department-admin";
import { Building } from 'lucide-react'

interface DepartmentHeadCardProps {
    userId: string
}

export default function DepartmentHeadCard({ userId }: DepartmentHeadCardProps) {
    const { departmentId: department, isLoading, error } = useUserDepartmentHead(userId)
    const departmentId = department?.id as string

    if (isLoading) {
        return (
            <Card className="shadow-md">
                <CardHeader>
                    <Skeleton className="h-6 w-3/4" />
                </CardHeader>
                <CardContent>
                    <Skeleton className="h-10 w-full" />
                </CardContent>
                <CardFooter>
                    <Skeleton className="h-10 w-full" />
                </CardFooter>
            </Card>
        )
    }

    if (error || !department) {
        return null
    }

    return (
        <Card className="flex flex-col">
            <CardHeader>
                <CardTitle className="flex items-center gap-2">
                    <Building className="h-6 w-6" />
                    Department Head
                </CardTitle>
                <CardDescription>You are a department head</CardDescription>
            </CardHeader>
            <CardContent className="flex-grow">
                <p className="text-sm text-gray-600">Your department is: <span className="font-semibold">{department.departmentName}</span></p>
            </CardContent>
            <CardFooter className="mt-auto">
                <Dialog>
                    <DialogTrigger className="w-full" asChild>
                        <Button variant="admin">
                            View Department
                        </Button>
                    </DialogTrigger>
                    <DialogContent className="p-0 min-w-[1000px] bg-transparent border-none">
                        <ViewDepartment departmentId={departmentId} />
                    </DialogContent>
                </Dialog>
            </CardFooter>
        </Card>
    )
}