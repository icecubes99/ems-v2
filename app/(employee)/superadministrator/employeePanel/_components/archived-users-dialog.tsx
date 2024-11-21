"use client"
import React, { useState, useTransition } from 'react'

import {
    Dialog,
    DialogContent,
    DialogTrigger
} from "@/components/ui/dialog";

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { FormError } from "@/components/form-error";
import { FormSucess } from "@/components/form-sucess";
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import useUser from '@/hooks/use-user';
import { Archive, Users } from 'lucide-react';
import TableWrapper from '@/components/table-wrapper';
import { DataTableTemplate } from '@/app/(leaves)/_components/data-table-template';
import { useArchivedUserList, useUserList } from '@/hooks/use-user-list';
import { columnsEmployeeList } from './columns-employees';
import { columnsArchivedEmployeeList } from './columns-archived-employees';

export const ArchivedUsersDialog = () => {
    const { users } = useArchivedUserList()
    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button className="w-full">
                    View Archived Users
                </Button>
            </DialogTrigger>
            <DialogContent className='p-0 w-full bg-transparent'>
                <Card className='w-full pt-4 '>
                    <CardContent className='w-full'>
                        <TableWrapper title="Archived Employees" description='List of Archived Employees' icon={<Users />} >
                            <DataTableTemplate searchValue='name' searchName='Name' columns={columnsArchivedEmployeeList} data={users} />
                        </TableWrapper>
                    </CardContent>
                </Card>
            </DialogContent>
        </Dialog>
    )
}