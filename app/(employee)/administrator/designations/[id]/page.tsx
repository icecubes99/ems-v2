// "use client"
// import { RoleGate } from '@/components/auth/role-gate'
// import LayoutSideHead from '@/components/LayoutSideHead'
// import React, { useEffect, useState } from 'react'

// import { DataTableDesignationUsers } from '@/app/(employee)/superadministrator/_components/DataTable-DesignationUsers'
// // import { columnsDesignation } from '@/app/(employee)/superadministrator/departments/designations/[id]/columns-designations'
// import { columnsDesignation } from './columns-designations'
// import { AssignDesignationWithUser } from '@/types/types'
// import useDesignation from '@/hooks/use-designation'

// const Page = ({ params }: { params: { id: string } }) => {
//     const [assignedUsers, setAssignedUsers] = useState<AssignDesignationWithUser[]>([]);
//     const [isLoading, setIsLoading] = useState(true);
//     const [error, setError] = useState<string | null>(null);

//     const fetchAssignedUsers = async () => {
//         setIsLoading(true);
//         setError(null);
//         try {
//             const response = await fetch(`/api/assignDesignation/${params.id}`, {
//                 method: 'GET',
//             });

//             if (!response.ok) {
//                 throw new Error('Failed to fetch assigned users');
//             }

//             const data: AssignDesignationWithUser[] = await response.json();
//             setAssignedUsers(data);
//         } catch (err) {
//             setError('An error occurred while fetching data');
//             console.error('Error fetching assigned users:', err);
//         } finally {
//             setIsLoading(false);
//         }
//     };

//     const { designation, loading } = useDesignation(params.id);
//     const designationName = designation?.designationName;

//     useEffect(() => {
//         fetchAssignedUsers();
//     }, [params.id]);

//     return (
//         <RoleGate allowedRoles={["SUPERADMIN", "ADMIN"]}>
//             <LayoutSideHead label='Designation'>
//                 <div className='mt-5'>
//                     <p className='font-bold text-4xl'><span className='text-purple-950'>{designationName}</span>'s Designated Users</p>
//                 </div>
//                 <div className='mt-5 pr-10'>
//                     {isLoading ? (
//                         <p>Loading...</p>
//                     ) : error ? (
//                         <p className="text-red-500">{error}</p>
//                     ) : (
//                         <DataTableDesignationUsers variant={"admin"} columns={columnsDesignation} data={assignedUsers} designationId={params.id} />
//                     )}
//                 </div>
//             </LayoutSideHead>
//         </RoleGate>
//     )
// }

// export default Page

// SERVER ACTION AND HOOK METHOD - SLOWER UGHHH
"use client"
import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React, { useCallback } from 'react'
import { DataTableDesignationUsers } from '@/app/(employee)/superadministrator/_components/DataTable-DesignationUsers'
import { columnsDesignation } from './columns-designations'
import useDesignation from '@/hooks/use-designation'
import { useAssignedUsers } from '@/hooks/use-assigned-users-from-fetch'
import { Button } from '@/components/ui/button'
import { IoReload } from "react-icons/io5";

const Page = ({ params }: { params: { id: string } }) => {
    const { assignedUsers, isLoading, error, refetch } = useAssignedUsers(params.id);
    const { designation, loading } = useDesignation(params.id);
    const designationName = designation?.designationName;

    const handleClick = useCallback((event: React.MouseEvent) => {
        event.preventDefault();
        console.log('Button clicked');
        refetch(); // Assuming you've added a refetch function to your useAssignedUsers hook
    }, [refetch]);

    console.log('Rendering Page component', { isLoading, error, assignedUsersCount: assignedUsers.length });

    return (
        <RoleGate allowedRoles={["SUPERADMIN", "ADMIN"]}>
            <LayoutSideHead label='Designation'>
                <div className='mt-5'>
                    <p className='font-bold text-4xl'>
                        <span className='text-purple-950'>{designationName}</span>'s Designated Users
                    </p>
                </div>
                <div className='mt-5 pr-10'>
                    <Button onClick={handleClick}>
                        <IoReload className='mr-2' /> Reload Users
                    </Button>
                    {isLoading ? (
                        <p>Loading...</p>
                    ) : error ? (
                        <p className="text-red-500">{error}</p>
                    ) : assignedUsers.length >= 0 ? (
                        <DataTableDesignationUsers
                            variant={"admin"}
                            columns={columnsDesignation}
                            data={assignedUsers}
                            designationId={params.id}
                        />
                    ) : (
                        <p>No assigned users found.</p>
                    )}
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default Page