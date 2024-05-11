"use client"

import { User } from "@supabase/supabase-js";
import { useEffect, useRef } from "react";
import userStore from "./user";

interface Props {
  user: User | null;
}

export default function InitUserState(props: Props) {
  const initState = useRef(false);
  useEffect(() => {
    if (!initState.current) {
      userStore.setState(props);
    }
    initState.current = true;
    return;
  }, [props]);
  return <></>;
}
