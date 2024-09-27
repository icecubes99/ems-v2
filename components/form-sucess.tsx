import { cn } from "@/lib/utils";
import { CheckCircledIcon } from "@radix-ui/react-icons";

interface FormSucessProps {
  message?: string;
  className?: string
}

export const FormSucess = ({ message, className }: FormSucessProps) => {
  if (!message) return null;

  return (
    <div className={cn("bg-destructive/10 p-3 rounded-md flex items-center gap-x-2 text-sm text-destructive", className)}>
      <CheckCircledIcon className="h-4 w-4" />
      <p>{message}</p>
    </div>
  );
};
