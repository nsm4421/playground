"use client";

import { getLocationOrigin } from "next/dist/shared/lib/utils";
import { Button } from "../ui/button";
import { User } from "@supabase/supabase-js";
import { useEffect, useState } from "react";
import getSupbaseBrowser from "@/lib/supabase/browser";

interface Props {
  loginLabel?: String;
  logoutLabel?: String;
  user: User | null;
}

export default function GoogleAuthButton(props: Props) {
  const supabase = getSupbaseBrowser();

  const [isLoading, setIsLoading] = useState(false);
  const [isLogin, setIsLogIn] = useState(false);

  useEffect(() => {
    if (props.user) {
      setIsLogIn(true);
    } else {
      setIsLogIn(false);
    }
    return;
  }, [props]);

  const handleLogin = async () => {
    try {
      setIsLoading(true);
      // 로그인
      await supabase.auth.signInWithOAuth({
        provider: "google",
        options: {
          redirectTo: `${getLocationOrigin()}/auth/callback`,
        },
      });
      setIsLogIn(true);
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogOut = async () => {
    try {
      setIsLoading(true);
      await supabase.auth.signOut(); //  로그아웃 처리
      setIsLogIn(false);
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return <Button>{"로딩중"}</Button>;
  } else if (isLogin) {
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
