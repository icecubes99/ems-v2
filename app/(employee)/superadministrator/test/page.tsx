"use client"
import useDesignationFromDepartment from '@/hooks/use-current-designationsFromDepartment';
import { Designation } from '@prisma/client';

import React from 'react'
import SelectDepartments from '../_components/SelectDepartments';

const page = () => {

    const { data, loading, error } = useDesignationFromDepartment("cm09la7y80003o3pzyepbqhxm");

    if (loading) {
        return <div>Loading...</div>;
    }

    if (error) {
        return <div>Error: {error}</div>;
    }
    return (
        <div>
            <h2>Designations</h2>
            {data && data.length > 0 ? (
                <ul>
                    {data.map((designation: Designation) => (
                        <li key={designation.id}>
                            <h3>{designation.designationName}</h3>
                            <p>{designation.designationDescription}</p>
                            <p>Status: {designation.status}</p>
                            <p>Department ID: {designation.departmentId}</p>
                            <p>Designation Head User ID: {designation.designationHeadUserId}</p>
                            <p>Created At: {designation.createdAt.toString()}</p>
                            <p>Updated At: {designation.updatedAt.toString()}</p>
                            <p>Created By: {designation.createdBy}</p>
                        </li>
                    ))}
                </ul>
            ) : (
                <p>No designations found.</p>
            )}
        </div>
    );
}

export default page