"use client";

import { getLocationOrigin } from "next/dist/shared/lib/utils";
import { Button } from "../ui/button";
import { User } from "@supabase/supabase-js";
import { useState } from "react";
import getSupbaseBrowser from "@/lib/supabase/browser";

interface Props {
  loginLabel?: String;
  logoutLabel?: String;
  currentUser: User | null;
}

export default function GoogleAuthButton(props: Props) {
  const auth = getSupbaseBrowser().auth;
  const [isLoading, setIsLoading] = useState(false);

  const handleLogin = async () => {
    try {
      setIsLoading(true);
      await auth.signInWithOAuth({
        provider: "google",
        options: {
          redirectTo: `${getLocationOrigin()}/auth/callback`,
        },
      });
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogOut = async () => {
    console.log("logout");
    try {
      setIsLoading(true);
      await auth.signOut();
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return <Button>{"로딩중"}</Button>;
  } else if (props.currentUser) {
    return (
      <Button onClick={handleLogOut} disabled={isLoading}>
        {props.logoutLabel ?? "로그아웃"}
      </Button>
    );
  } else {
    return (
      <Button onClick={handleLogin} disabled={isLoading}>
        {props.loginLabel ?? "로그인"}
      </Button>
    );
  }
}
