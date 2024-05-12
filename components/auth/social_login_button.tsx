"use client";

import { getLocationOrigin } from "next/dist/shared/lib/utils";
import { Button } from "../ui/button";
import { useState } from "react";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { useUser } from "@/lib/store/user/user";
import LogOutButton from "./logout_button";
import { toast } from "sonner";

interface Props {
  loginLabel?: String;
  logoutLabel?: String;
  showLogoutButton?: boolean;
  provider: "google" | "github";
}

export default function SocialLoginButton(props: Props) {
  const supabase = getSupbaseBrowser();
  const [isLoading, setIsLoading] = useState(false);
  const { sessionUser } = useUser();

  const handleLogin = async () => {
    try {
      setIsLoading(true);
      const { data, error } = await supabase.auth.signInWithOAuth({
        provider: props.provider,
        options: {
          redirectTo: `${getLocationOrigin()}/auth/callback`,
        },
      });
      if (error) {
        console.error(error);
        toast.error("회원가입 실패");
      } else {
        console.debug(data);
      }
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  if (sessionUser) {
    // 로그인한 경우
    return props.showLogoutButton ? (
      <LogOutButton label={props.logoutLabel} />
    ) : (
      <></>
    );
  } else {
    // 로그인하지 않은 경우
    return (
      <Button
        onClick={handleLogin}
        disabled={isLoading}
        className={`w-full ${isLoading ? "cursor-wait" : "cursor-pointer"}`}
      >
        {props.loginLabel ?? "로그인"}
      </Button>
    );
  }
}
