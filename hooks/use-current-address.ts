// useAddress.ts
import { useState, useEffect } from 'react';
import { getAddress } from '@/actions/readAddress';
import { Address } from '@/next-auth'; // Adjust the import path as necessary

const useAddress = (userId: string) => {
    const [address, setAddress] = useState<Address | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchAddress = async () => {
            setLoading(true);
            setError(null);

            try {
                const response = await getAddress(userId);

                if (response.error) {
                    setError(response.error);
                    setAddress(null);
                } else {
                    setAddress(response.data as Address);
                }
            } catch (error) {
                // setError(error.message);
                setAddress(null);
            } finally {
                setLoading(false);
            }
        };

        fetchAddress();
    }, [userId]);

    const { street, barangay, city, province, country, zipCode } = address || {};

    return { street, barangay, city, province, country, zipCode, loading, address };
};

export default useAddress;