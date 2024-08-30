import { useState, useEffect } from "react";
import { getLoneDesignation } from "@/actions/superadmin/getDesignations";
import { Designation } from "@prisma/client";

const useDesignation = (designationId: string) => {

    const [designation, setDesignation] = useState<Designation | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchDesignation = async () => {
            setLoading(true);
            setError(null);

            try {
                const response = await getLoneDesignation(designationId);

                if (response.error) {
                    setError(response.error);
                    setDesignation(null);
                } else {
                    setDesignation(response.data as Designation)
                }
            } catch (error) {
                setDesignation(null);
            } finally {
                setLoading(false);
            }
        };

        fetchDesignation()
    }, [designationId]);

    const { designationName, designationDescription, status, departmentId, designationHeadUserId } = designation || {};

    return { designationName, designationDescription, status, departmentId, designationHeadUserId, loading, error, designation }
}

export default useDesignation;