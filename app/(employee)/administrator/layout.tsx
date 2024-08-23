import { RoleGate } from "@/components/auth/role-gate";
import Sidebar from "@/components/Sidebar";

interface ProtectedLayoutProps {
    children: React.ReactNode;
}

const ProtectedLayout = ({ children }: ProtectedLayoutProps) => {
    return (
        <RoleGate allowedRoles={["ADMIN", "SUPERADMIN"]}>
            {children}
        </RoleGate>
    );
};

export default ProtectedLayout;
