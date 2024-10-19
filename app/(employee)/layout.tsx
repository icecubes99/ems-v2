"use client"
import { RoleGate } from "@/components/auth/role-gate";
import { Toaster } from "@/components/ui/toaster";

interface ProtectedLayoutProps {
    children: React.ReactNode;
}

const ProtectedLayout = ({ children }: ProtectedLayoutProps) => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN", "ADMIN", "USER"]}>
            <Toaster />
            {children}
        </RoleGate>
    );
};

export default ProtectedLayout;
