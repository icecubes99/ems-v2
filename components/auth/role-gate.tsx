"use client";

import { UserRole } from "@prisma/client";
import { FormError } from "@/components/form-error";
import { useCurrentRole } from "@/hooks/use-current-role";
import NotFound from "next/error";

interface RoleGateProps {
  children: React.ReactNode;
  allowedRoles: UserRole[];
}

export const RoleGate: React.FC<RoleGateProps> = ({ children, allowedRoles }) => {
  const role = useCurrentRole();

  if (!role || !allowedRoles.includes(role)) {
    return (
      <>
        <FormError message="You do not have permission to view this content!" />
        <NotFound statusCode={404} />
      </>

    );
  }

  return <>{children}</>;
};
