import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Briefcase, Building, CalendarClock, Plus, Users } from "lucide-react"
import { useTotalDepartmentsCount, useTotalDesignationCount, useTotalUserCount } from "@/hooks/use-ModelCounts"
import { HolidayTable } from "@/components/holidays-table"
import { TimesheetDialog } from "@/components/Timesheet"
import RequestOvertime from "./request-overtime"
import HeadingCard from "@/components/heading-card"
import { Head } from "react-day-picker"
import { IoDocument, IoDocumentAttach, IoSparklesOutline } from "react-icons/io5"
import { CgSpinnerTwoAlt } from "react-icons/cg";
import QuickActions from "@/components/quick-actions"
import { UploadDocumentForm } from "@/app/(employee)/_components/upload-documents-dialog"
import TableWrapper from "@/components/table-wrapper"
import { DataTableTemplate } from "@/app/(leaves)/_components/data-table-template"
import { columnsUserDocuments } from "./columns-user-documents"
import { useUserDocuments } from "@/hooks/use-documents"
import { useCurrentUser } from "@/hooks/use-current-user"


const HomepageCards = () => {
    const { userCount, error, isLoading } = useTotalUserCount()
    const { departmentCount, isLoading: depLoading } = useTotalDepartmentsCount()
    const { designationCount, isLoading: desLoading } = useTotalDesignationCount()
    const user = useCurrentUser()
    const { documents } = useUserDocuments(user?.id as string)
    return (
        <>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5 ">
                <HeadingCard
                    title='Total Employees'
                    count={userCount}
                    icon={<Users />}
                    isLoading={isLoading}
                />

                <HeadingCard title='Departments' count={departmentCount} icon={<Building />} isLoading={depLoading} />

                <HeadingCard title='Designations' count={designationCount} icon={<Briefcase />} isLoading={desLoading} />

                <HeadingCard title='Documents' count={21} icon={<IoDocumentAttach />} isLoading={isLoading} />

            </div>

            <QuickActions className="lg:grid-cols-3">
                <TimesheetDialog classname=" " />
                <RequestOvertime />
                <UploadDocumentForm />
            </QuickActions>

            <p className="col-span-4 font-bold  text-lg">MISC</p>
            <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mb-8 mt-5">
                <HolidayTable className="" />
                <TableWrapper className="col-span-2" title="Documents" description="Your own Documents" icon={<IoDocument />}>
                    <DataTableTemplate columns={columnsUserDocuments} data={documents || []} />
                </TableWrapper>
            </div>
        </>
    )
}

export default HomepageCards
