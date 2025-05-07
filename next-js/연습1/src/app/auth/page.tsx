import { Button } from "@/lib/ui/button";
import AuthButton from "./_components/auth-button";

export default function AuthPage() {
  return (
    <div className="flex h-screen w-full">
      <div className="flex flex-1 justify-center items-center bg-slate-400 dark:bg-slate-700">
        <h1 className="text-3xl font-bold">Chat App</h1>
      </div>
      <div className="flex flex-1 justify-center items-center bg-slate-200 dark:bg-slate-500">
        <div className="flex flex-col gap-y-3">
          <h3 className="text-xl font-bold">Start</h3>
          <AuthButton />
        </div>
      </div>
    </div>
  );
}
