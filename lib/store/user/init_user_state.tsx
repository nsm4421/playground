"use client";

import { User } from "@supabase/supabase-js";
import { useEffect, useRef } from "react";
import { useUser } from "./user";

interface Props {
  sessionUser: User | null;
}

export function InitUserState(props: Props) {
  const initState = useRef(false);
  useEffect(() => {
    if (!initState.current) {
      useUser.setState({
        ...props,
        basicUser: {
          id: props.sessionUser!.id,
          username: props.sessionUser?.user_metadata.name,
          avatar_url: props.sessionUser?.user_metadata.avatar_url,
          created_at: props.sessionUser?.created_at,
        },
      });
    }
    initState.current = true;
    return;
  }, [props]);
  return <></>;
}
