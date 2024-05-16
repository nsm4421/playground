"use client";

import SignOutAction from "@/lib/supabase/action/sign-out";
import { faSignOut } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useState } from "react";

interface Props {
  size?: number;
}

export default function LogoutButton(props: Props) {
  const size = props.size ?? 4;
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleLogout = async () => {
    if (isLoading) {
      return;
    }
    try {
      setIsLoading(true);
      await SignOutAction();
      console.log("signout");
    } catch (error) {
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <FontAwesomeIcon
      className={`w-${size} h-${size} hover:bg-slate-200 p-2 rounded-full ${
        isLoading ? "cursor-wait" : "cursor-pointer"
      }`}
      icon={faSignOut}
      onClick={handleLogout}
    />
  );
}
