"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React, { useState } from 'react'
import EmployeePageContent from './_components/employee-page-content'
import { columnsEmployeeList } from './_components/columns-employees'
import { useUserList } from '@/hooks/use-user-list'
import { DataTable } from './_components/DataTable'
import TableWrapper from '@/components/table-wrapper'
import { Users } from 'lucide-react'
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template'
const page = () => {

    const { users } = useUserList()

    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead>
                <EmployeePageContent />
                <TableWrapper title="Employees" description='List of Employee' icon={<Users />} >
                    <DataTableTemplate searchValue='name' columns={columnsEmployeeList} data={users} />
                </TableWrapper>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page