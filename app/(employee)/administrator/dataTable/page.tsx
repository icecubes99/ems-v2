"use client"
import React, { useEffect, useState } from 'react'
import { columns, UserList } from './columns';
import { DataTable } from '../../_components/DataTable';
import LayoutSideHead from '@/components/LayoutSideHead';


const page = () => {

    const [users, setUsers] = useState<UserList[]>([]);

    const makeApiCall = async () => {
        const response = await fetch('/api/users', {
            method: 'GET',
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const users = await response.json();
        const processedUsers = users.map((user: any) => {
            const name = user?.firstName + ' ' + user?.lastName;

            return {
                ...user,
                name,
            };
        })

        setUsers(processedUsers);
        // console.log("THIS IS THE RESPONSE" + setUsers)
    };

    useEffect(() => {
        makeApiCall();
    }, [])

    return (
        <LayoutSideHead label='Data Table'>
            <section className="py-10">
                <div className="mr-6">
                    <h1 className="text-3xl">
                        <DataTable columns={columns} data={users} />
                    </h1>
                </div>
            </section>
        </LayoutSideHead>
    )
}

export default page