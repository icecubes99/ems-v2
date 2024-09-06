import { useUserDepartmentHead } from "@/hooks/use-user-department-head";

import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Skeleton } from "@/components/ui/skeleton"
import Link from "next/link"
import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";
import ViewDepartment from "./view-department-admin";

interface DepartmentHeadCardProps {
    userId: string
}

export default function DepartmentHeadCard({ userId }: DepartmentHeadCardProps) {
    const { departmentId: department, isLoading, error } = useUserDepartmentHead(userId)
    const departmentId = department?.id as string

    if (isLoading) {
        return (
            <Card>
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
        <Card>
            <CardHeader>
                <CardTitle>Department Head</CardTitle>
                <CardDescription>You are a department head</CardDescription>
            </CardHeader>
            <CardContent>
                <p>Your department is: {department.departmentName}</p>
            </CardContent>
            <CardFooter>
                {/* <Link href={`/administrator/departments/${department.id}`} passHref legacyBehavior>
                    <Button className="w-full" variant="admin">
                        View Designation
                    </Button>
                </Link> */}
                <Dialog>
                    <DialogTrigger className="w-full" asChild>
                        <Button variant={"admin"}>
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