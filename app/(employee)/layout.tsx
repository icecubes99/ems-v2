import Sidebar from "@/components/Sidebar";

interface ProtectedLayoutProps {
    children: React.ReactNode;
}

const ProtectedLayout = ({ children }: ProtectedLayoutProps) => {
    return (
        <div className="">
            {children}
        </div>
    );
};

export default ProtectedLayout;
