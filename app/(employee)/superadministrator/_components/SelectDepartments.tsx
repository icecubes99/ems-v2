import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Department } from '@prisma/client';
import React, { useEffect, useState } from 'react';

interface SelectUserProps {
    onUserChange: (userId: string) => void;
    value?: string;
}

const SelectDepartments: React.FC<SelectUserProps> = ({ onUserChange, value }) => {
    const [departments, setdepartments] = useState<Department[]>([]);

    const makeApiCall = async () => {
        const response = await fetch('/api/departments', {
            method: 'GET',
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const departments = await response.json();

        setdepartments(departments);
    };

    useEffect(() => {
        makeApiCall();
    }, []);

    const handleChange = (value: string) => {
        console.log(`Selected Department: ${value}`);
        onUserChange(value);
    };

    return (
        <Select onValueChange={handleChange} value={value}>
            <SelectTrigger>
                <SelectValue placeholder="Pick a Department"></SelectValue>
            </SelectTrigger>
            <SelectContent>
                {departments.map(departments => (
                    <SelectItem key={departments.id} value={departments.id}>{departments.departmentName}</SelectItem>
                ))}
            </SelectContent>
        </Select>
    );
};

export default SelectDepartments;