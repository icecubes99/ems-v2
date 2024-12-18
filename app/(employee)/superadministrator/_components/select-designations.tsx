import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { useSelectDesignations } from '@/hooks/use-designations';
import { Designation } from '@prisma/client';
import React, { useEffect, useState } from 'react';

interface SelectDesignationProps {
    onUserChange: (userId: string) => void;
    value?: string;
}

const SelectDesignation: React.FC<SelectDesignationProps> = ({ onUserChange, value }) => {
    const { designations, isLoading, error } = useSelectDesignations()

    if (isLoading) return <div>Loading...</div>
    if (error) return <div>Error: {error}</div>

    const handleChange = (value: string) => {
        console.log(`Selected Designation: ${value}`)
        onUserChange(value)
    }

    return (
        <Select onValueChange={handleChange} value={value}>
            <SelectTrigger>
                <SelectValue placeholder="Pick a Designation"></SelectValue>
            </SelectTrigger>
            <SelectContent>
                {designations?.map(designation => (
                    <SelectItem
                        key={designation.id}
                        value={designation.id}
                    >
                        {designation.designationName}
                    </SelectItem>
                ))}
            </SelectContent>
        </Select>
    )
}

export default SelectDesignation;