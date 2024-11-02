import { useState, useEffect } from 'react';
import { db } from '@/lib/db'; // Adjust the import according to your project structure
import { User } from '@prisma/client';
import { getSpecificUser } from '@/actions/getSpecificUser';

export const useUser = (userId: string) => {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | unknown>(null);

    useEffect(() => {
        const fetchUser = async () => {
            setLoading(true);
            setError(null);

            try {
                const response = await getSpecificUser(userId);

                if (response.error) {
                    setError(response.error);
                    setUser(null);
                } else {
                    setUser(response.data as User);
                }

            } catch (error) {
                setUser(null);
            } finally {
                setLoading(false);
            }
        }

        fetchUser();

    }, [userId]);

    const { firstName, middleName, lastName, email, gender, jobTitle, vacationDays, incentiveDays, dateOfBirth, role } = user || {};

    return { firstName, middleName, lastName, email, gender, jobTitle, vacationDays, incentiveDays, loading, dateOfBirth, user, error, role };
};
export default useUser;