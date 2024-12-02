import { Poppins } from "next/font/google";

import { cn } from "@/lib/utils";

import { Button } from "@/components/ui/button";
import LoginButton from "@/components/auth/login-button";

const font = Poppins({
  subsets: ["latin"],
  weight: ["600"],
});
export default function Home() {
  return (
    <main className="h-screen bg-purple-100 flex flex-row">

      {/* <div className="h-screen hidden md:flex bg-black -mr-80  items-center justify-center w-full text-white">
        <p className="mr-80">
          Sexy Image Here
        </p>
      </div> */}

      <div className="h-screen w-full bg-gradient-to-t from-purple-500 to-purple-700 flex flex-col gap-2 items-center justify-center">
        <div className="text-5xl text-white text-center font-bold">
          Kupler Industries Inc.
        </div>
        <div className="text-white/80 font-medium">Employee Management System</div>
        <div className="mt-4">
          <LoginButton mode="redirect" asChild>
            <Button variant="secondary" size="lg">
              Sign in
            </Button>
          </LoginButton>
        </div>
      </div>

    </main>
  );
}
