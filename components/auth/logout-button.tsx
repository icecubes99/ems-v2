"use client";

import { logout } from "@/actions/logout";
import { useRouter } from "next/navigation";

interface LogoutButtonProps {
  children?: React.ReactNode;
  userId: string;
}

export const LogoutButton = ({ children, userId }: LogoutButtonProps) => {
  const router = useRouter();

  const onClick = () => {
    logout(userId).then(() => {
      router.refresh();
    });
  };

  return (
    <span onClick={onClick} className="cursor-pointer">
      {children}
    </span>
  );
};
