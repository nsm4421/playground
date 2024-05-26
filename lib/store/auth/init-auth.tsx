"use client";

import { useCallback, useEffect, useRef } from "react";
import useAuth from "./auth-state";
import getCurrentUser from "@/lib/supabase/action/get-current-user";

export default function InitAuth() {
  const initState = useRef(false);
  const { user, setUser } = useAuth();

  const getUserCallback = useCallback(async () => {
    if (!user) {
      await getCurrentUser().then(setUser);
    }
  }, [setUser, user]);

  useEffect(() => {
    if (!initState.current) {
      getUserCallback();
    }
    initState.current = true;
  }, [getUserCallback]);
  return <></>;
}
