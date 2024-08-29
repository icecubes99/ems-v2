
"use client"
import React, { useEffect, useState } from 'react'
import { columns, } from './columns';

import LayoutSideHead from '@/components/LayoutSideHead';
import { Department } from '@prisma/client';
import { DataTableDepartments } from '../_components/DataTableDepartments';

const page = () => {


    const [departments, setDepartments] = useState<Department[]>([]);

    const makeApiCall = async () => {
        const response = await fetch('/api/departments', {
            method: 'GET',
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const departments = await response.json();

        setDepartments(departments);
        console.log("THIS IS THE RESPONSE" + setDepartments)
    };

    useEffect(() => {
        makeApiCall();
    }, [])

    return (
        <LayoutSideHead label='Data Table'>
            <section className="py-10">
                <div className="container">
                    <h1 className="text-3xl">
                        <DataTableDepartments columns={columns} data={departments} />
                    </h1>
                </div>
            </section>
        </LayoutSideHead>
    )
}

export default page