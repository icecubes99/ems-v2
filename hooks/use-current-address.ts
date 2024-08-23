import { useState, useEffect } from 'react';
import { Address } from '@/next-auth';

const useUserAddress = (userId: string) => {
    const [address, setAddress] = useState<Address | undefined>(undefined);

    useEffect(() => {
        const fetchAddress = async () => {
            try {
                const response = await fetch(`/api/users/addressLine/${userId}`);
                const data = await response.json();
                setAddress(data);
            } catch (error) {
                console.error('Error fetching address:', error);
            }
        };

        if (userId) {
            fetchAddress();
        }
    }, [userId]);

    return address;
};

export default useUserAddress;