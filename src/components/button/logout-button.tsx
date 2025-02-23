"use client";

import LogoutIcon from "@/components/icon/logout-icon";
import { useRouter } from "next/navigation";
import { signOut } from "next-auth/react";
import { RoutePaths } from "@/lib/constant/route";
import { useState } from "react";
import { cn } from "../utils";

interface Props {
  label?: string;
}

export default function LogoutButton({ label }: Props) {
  const [isPending, setIsPending] = useState<boolean>(false);
  const router = useRouter();
  const handleLogout = async () => {
    if (isPending) return;
    setIsPending(true);
    try {
      await signOut().then((_) => {
        router.replace(RoutePaths.entry);
      });
    } catch (error) {
      console.error(error);
    } finally {
      setIsPending(false);
    }
  };

  return (
    <div
      onClick={handleLogout}
      className={cn(
        "flex gap-x-1 group cursor-pointer",
        isPending && "cursor-wait"
      )}
    >
      <LogoutIcon clsName="group-hover:text-sky-600" />

      {label && (
        <label className="text-md cursor-pointer group-hover:text-sky-600 group-hover:font-bold">
          {label}
        </label>
      )}
    </div>
  );
}
