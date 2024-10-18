"use client"
import { useUserList } from '@/hooks/use-user-list'
import React from 'react'
import { LiteMultiSelect } from './lite-multi-select'
import { useDesignationList } from '@/hooks/use-designation'
import { useDepartmentList } from '@/hooks/use-department'

interface MultiSelectUsersProps {
    onChange: (value: string[]) => void
}
export const MultiSelectUsers = ({ onChange }: MultiSelectUsersProps) => {
    const { users } = useUserList()

    const userOptions = users?.map((user) => ({
        value: user.id,
        label: `${user.firstName} ${user.lastName}`
    })) || []
    return (
        <LiteMultiSelect
            options={userOptions}
            onChange={onChange}
            placeholder="Select users"
            itemName='user'
        />
    )
}

export const MultiSelectDesignations = ({ onChange }: MultiSelectUsersProps) => {
    const { designations } = useDesignationList()

    const designationOptions = designations?.map((designation) => ({
        value: designation.id,
        label: designation.designationName
    })) || []

    return (
        <LiteMultiSelect
            options={designationOptions}
            onChange={onChange}
            placeholder="Select designations"
            itemName='designation'
        />
    )
}

export const MultiSelectDepartments = ({ onChange }: MultiSelectUsersProps) => {
    const { departments } = useDepartmentList()

    const departmentOptions = departments?.map((department) => ({
        value: department.id,
        label: department.departmentName
    })) || []

    return (
        <LiteMultiSelect
            options={departmentOptions}
            onChange={onChange}
            placeholder="Select departments"
            itemName='department'
        />
    )
}
