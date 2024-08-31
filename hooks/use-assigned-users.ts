import { useState, useEffect } from "react";

import { getAssignedUser } from "@/actions/superadmin/getAssignedUser";
import { AssignDesignation } from "@prisma/client";

const useAssignedUser = (assignedUserId: string) => {

    const [assignedUser, setAssignedUser] = useState<AssignDesignation | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchAssignedUser = async () => {
            setLoading(true);
            setError(null);

            try {
                const response = await getAssignedUser(assignedUserId);

                if (response.error) {
                    setError(response.error);
                    setAssignedUser(null);
                } else {
                    setAssignedUser(response.data as AssignDesignation)
                }
            } catch (error) {
                setAssignedUser(null);
            } finally {
                setLoading(false);
            }
        };

        fetchAssignedUser()
    }, [assignedUserId]);

    const { userId, employeeType, status, designationId } = assignedUser || {};

    return { userId, employeeType, status, designationId, loading, error, assignedUser }
}

export default useAssignedUser;