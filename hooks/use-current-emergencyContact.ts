
import { useState, useEffect } from "react";
import { getEmergencyContact } from "@/actions/getEmergencyContact";
import { EmergencyContact } from "@prisma/client";

const useEmergencyContact = (userId: string) => {

    const [emergencyContact, setEmergencyContact] = useState<EmergencyContact | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchEmergencyContact = async () => {
            setLoading(true);
            setError(null);

            try {
                const response = await getEmergencyContact(userId);

                if (response.error) {
                    setError(response.error);
                    setEmergencyContact(null);
                } else {
                    setEmergencyContact(response.data as EmergencyContact);
                }
            } catch (error) {
                setEmergencyContact(null);
            } finally {
                setLoading(false);
            }
        };

        fetchEmergencyContact();
    }, [userId]);

    const { firstName, middleName, lastName, relationship, contactNumber, emailAddress } = emergencyContact || {};

    return { firstName, middleName, lastName, relationship, contactNumber, emailAddress, loading, emergencyContact }
};
export default useEmergencyContact;