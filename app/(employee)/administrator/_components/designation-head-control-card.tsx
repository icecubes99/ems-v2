import { useUserDesignationHead } from "@/hooks/use-user-designation-head"
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Skeleton } from "@/components/ui/skeleton"
import Link from "next/link"
import { Award } from 'lucide-react'

interface DesignationHeadCardProps {
    userId: string
}

export default function DesignationHeadCard({ userId }: DesignationHeadCardProps) {
    const { designationId: designation, isLoading, error } = useUserDesignationHead(userId)

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

    if (error || !designation) {
        return null
    }

    return (
        <Card>
            <CardHeader>
                <CardTitle className="flex items-center gap-2">
                    <Award className="h-6 w-6" />
                    Designation Head
                </CardTitle>
                <CardDescription>You are a designation head</CardDescription>
            </CardHeader>
            <CardContent>
                <p className="text-sm text-gray-600">Your designation is: <span className="font-semibold">{designation.designationName}</span></p>
            </CardContent>
            <CardFooter>
                <Link href={`/administrator/designations/${designation.id}`} passHref legacyBehavior>
                    <Button className="w-full" variant="admin">
                        View Designation
                    </Button>
                </Link>
            </CardFooter>
        </Card>
    )
}