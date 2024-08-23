const AuthLayout = ({ children }: { children: React.ReactNode }) => {
  return (
    <div
      className="
          h-full flex items-center justify-center
          bg-[conic-gradient(at_top,_var(--tw-gradient-stops))] from-violet-900 via-purple-600 to-violet-900
        "
    >
      {children}
    </div>
  );
};

export default AuthLayout;
