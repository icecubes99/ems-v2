import { useState, useEffect } from "react";
import { getDesignations, getLoneDesignation } from "@/actions/superadmin/getDesignations";
import { Designation } from "@prisma/client";

export const useDesignation = (designationId: string) => {

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

    const { designationName, designationDescription, status, departmentId, designationHeadUserId, designationSalary } = designation || {};

    return { designationName, designationDescription, status, departmentId, designationHeadUserId, loading, error, designation, designationSalary };
}

export const useDesignationList = () => {
    const [designations, setDesignations] = useState<Designation[]>([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState<Error | null>(null)

    useEffect(() => {
        async function loadDesignations() {
            try {
                setLoading(true)
                const fetchedDesignations = await getDesignations()
                setDesignations(fetchedDesignations.data || [])
            } catch (e) {
                setError(e instanceof Error ? e : new Error('An error occurred while fetching designations'))
            } finally {
                setLoading(false)
            }
        }

        loadDesignations()
    }, [])

    return { designations, loading, error }
}