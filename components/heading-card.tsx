import React, { ReactNode } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { CgSpinnerTwoAlt } from "react-icons/cg";


interface HeadingCardProps {
    title: string
    count: ReactNode
    icon?: React.ReactNode
    isLoading?: boolean
}

const HeadingCard = ({ title, count, icon, isLoading }: HeadingCardProps) => {
    return (
        <Card className="hover:shadow-md transition-shadow duration-300">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-8">
                <CardTitle>
                    {title}
                </CardTitle>
                <div className="h-4 w-4 text-muted-foreground">
                    {icon && React.cloneElement(icon as React.ReactElement, { className: "h-4 w-4 text-muted-foreground" })}
                </div>
            </CardHeader>
            <CardContent>
                <div className="text-2xl font-bold">
                    {isLoading ? <CgSpinnerTwoAlt className="animate-spin" /> : count}
                </div>
            </CardContent>
        </Card>
    )
}

export default HeadingCard