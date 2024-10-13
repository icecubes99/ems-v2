"use client"
import { fetchAuditLogs, fetchSingleAuditLog } from "@/data/fetch-audit-logs";
import { AuditLogWithUser } from "@/types/types";
import { useEffect, useState } from "react";

export function useAuditLogs() {
    const [auditLogs, setAuditLogs] = useState<AuditLogWithUser[] | null>(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const getAuditLogs = async () => {
            setLoading(true);
            setError(null);

            try {
                const result = await fetchAuditLogs();

                if (result.error) {
                    setError(result.error);
                    setAuditLogs(null);
                } else {
                    setAuditLogs(result.auditLogs as AuditLogWithUser[]);
                }

            } catch (error) {
                setError("An error occured while fetching data");
                console.error("Error fetching Audit Logs", error);
                setAuditLogs(null);
            } finally {
                setLoading(false);
            }
        };

        getAuditLogs();
    }, []);

    return { auditLogs, loading, error }
}

export function useUserAuditLog(userId: string) {
    const [auditLogs, setAuditLogs] = useState<AuditLogWithUser[] | null>(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const getAuditLogs = async () => {
            setLoading(true);
            setError(null);

            try {
                const result = await fetchSingleAuditLog(userId);

                if (result.error) {
                    setError(result.error);
                    setAuditLogs(null);
                } else {
                    setAuditLogs(result.auditLog as AuditLogWithUser[]);
                }

            } catch (error) {
                setError("An error occured while fetching data");
                console.error("Error fetching Audit Logs", error);
                setAuditLogs(null);
            } finally {
                setLoading(false);
            }
        };

        getAuditLogs();
    }, []);

    return { auditLogs, loading, error }
}