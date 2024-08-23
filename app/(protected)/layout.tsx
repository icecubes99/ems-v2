import Navbar from "./_components/navbar";

interface ProtectedLayoutProps {
  children: React.ReactNode;
}

const ProtectedLayout = ({ children }: ProtectedLayoutProps) => {
  return (
    <div
      className="
        min-h-screen w-full flex flex-col gap-y-10 items-center justify-center 
        bg-[conic-gradient(at_top,_var(--tw-gradient-stops))] from-purple-900 via-violet-600 to-purple-900
    "
    >
      <Navbar />
      {children}
    </div>
  );
};

export default ProtectedLayout;
