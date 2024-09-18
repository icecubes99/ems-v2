import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Designation } from '@prisma/client';
import React, { useEffect, useState } from 'react';

interface SelectDesignationProps {
    onUserChange: (userId: string) => void;
    value?: string;
}

const SelectDesignation: React.FC<SelectDesignationProps> = ({ onUserChange, value }) => {
    const [designations, setDesignations] = useState<Designation[]>([]);


    const makeApiCall = async () => {
        const response = await fetch('/api/designations', {
            method: 'GET',
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const designations = await response.json();

        setDesignations(designations);
    };

    useEffect(() => {
        makeApiCall();
    }, []);

    const handleChange = (value: string) => {
        console.log(`Selected Designation: ${value}`);
        onUserChange(value);
    };

    return (
        <Select onValueChange={handleChange} value={value}>
            <SelectTrigger>
                <SelectValue placeholder="Pick a Designation"></SelectValue>
            </SelectTrigger>
            <SelectContent>
                {designations.map(designations => (
                    <SelectItem key={designations.id} value={designations.id}>{designations.designationName}</SelectItem>
                ))}
            </SelectContent>
        </Select>
    )
}

export default SelectDesignation;