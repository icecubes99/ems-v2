import { useState, useEffect } from "react";
import { getAssignedUserByUserId } from "@/actions/superadmin/getAssignedUser";
import { AssignDesignation } from "@prisma/client";
import { useDesignation } from "./use-designation";

const useUserAssignment = (userId: string) => {

    const [assignment, setAssignment] = useState<AssignDesignation | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchAssignment = async () => {
            setLoading(true);
            setError(null);

            try {
                const response = await getAssignedUserByUserId(userId);

                if (response.error) {
                    setError(response.error);
                    setAssignment(null);
                } else {
                    setAssignment(response.data as AssignDesignation);
                }
            } catch (error) {
                setAssignment(null);
            } finally {
                setLoading(false);
            }
        };

        fetchAssignment();
    }, [userId]);

    const { designationId, status, employeeType } = assignment || {};

    const designation = useDesignation(designationId as string);
    const designationName = designation?.designationName;

    return { designationId, status, employeeType, designationName, error, loading, assignment }

}
export default useUserAssignment;