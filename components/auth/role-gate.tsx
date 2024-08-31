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
        <div className="bg-violet-950 max-h-screen overflow-hidden flex flex-col items-center justify-center">
          <div className="pt-28">
            <FormError message="You do not have permission to view this content! Please ask your adminstrators if something is wrong." />
          </div>
          <div className="-mt-28">
            <NotFound statusCode={404} />
          </div>
        </div>
      </>

    );
  }

  return <>{children}</>;
};
