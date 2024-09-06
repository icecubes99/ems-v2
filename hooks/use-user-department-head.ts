import { useState, useEffect } from "react";
import { getSpecificUserDepartmentHead } from "@/actions/getSpecificUser";
import { Department } from "@prisma/client";

export function useUserDepartmentHead(userId: string) {
    const [departmentId, setDepartmentId] = useState<Department | null>(null);
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        async function fetchDepartmentHead() {
            try {
                setIsLoading(true)
                const result = await getSpecificUserDepartmentHead(userId)
                if ('error' in result) {
                    setError(result.error as string)
                } else if (result.success && result.data.department) {
                    setDepartmentId(result.data.department)
                } else {
                    setError('Designation not found')
                }
            } catch (err) {
                setError("An error has occured while fetching the department")
            } finally {
                setIsLoading(false)
            }
        }

        fetchDepartmentHead()
    }, [userId])

    return { departmentId, isLoading, error }
}