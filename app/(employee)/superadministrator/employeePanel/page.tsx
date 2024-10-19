"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React, { useState } from 'react'
import EmployeePageContent from './_components/employee-page-content'
import { columnsEmployeeList } from './_components/columns-employees'
import { useUserList } from '@/hooks/use-user-list'
import { DataTable } from './_components/DataTable'
const page = () => {

    const { users } = useUserList()

    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead>
                <EmployeePageContent />

                <div className='mr-6 mb-5'>
                    <p className="col-span-4 font-bold  text-lg">EMPLOYEE LIST</p>
                    <DataTable columns={columnsEmployeeList} data={users} />
                </div>

            </LayoutSideHead>
        </RoleGate>
    )
}

export default page