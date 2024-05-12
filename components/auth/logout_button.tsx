"use client";

import { Button } from "../ui/button";
import { useState } from "react";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { useUser } from "@/lib/store/user/user";

interface Props {
  label?: String;
}

export default function LogOutButton(props: Props) {
  const supabase = getSupbaseBrowser();
  const [isLoading, setIsLoading] = useState(false);

  const handleLogOut = async () => {
    try {
      setIsLoading(true);
      await supabase.auth.signOut(); //  로그아웃 처리
      useUser.setState(() => ({ sessionUser: null, basicUser: null }));
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Button
      onClick={handleLogOut}
      disabled={isLoading}
      className={`w-full ${isLoading ? "cursor-wait" : "cursor-pointer"}`}
    >
      {props.label ?? "로그아웃"}
    </Button>
  );
}
