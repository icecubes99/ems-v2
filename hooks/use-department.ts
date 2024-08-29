import { useState, useEffect } from "react";
import { getDepartment } from "@/actions/superadmin/getDepartment";
import { Department } from "@prisma/client";

const useDepartment = (departmentId: string) => {

    const [department, setDepartment] = useState<Department | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchDepartment = async () => {
            setLoading(true);
            setError(null);

            try {
                const response = await getDepartment(departmentId);

                if (response.error) {
                    setError(response.error);
                    setDepartment(null);
                } else {
                    setDepartment(response.data as Department);
                }
            } catch (error) {
                setDepartment(null);
            } finally {
                setLoading(false);
            }
        };

        fetchDepartment();
    }, [departmentId]);

    const { departmentName, departmentDescription, departmentHeadUserId, status } = department || {};

    return { departmentName, departmentDescription, departmentHeadUserId, status, loading, department }
}

export default useDepartment;