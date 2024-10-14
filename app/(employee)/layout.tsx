"use client"
import { RoleGate } from "@/components/auth/role-gate";

interface ProtectedLayoutProps {
    children: React.ReactNode;
}

const ProtectedLayout = ({ children }: ProtectedLayoutProps) => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            {children}
        </RoleGate>
    );
};

export default ProtectedLayout;
