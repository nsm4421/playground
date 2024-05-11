"use client";

import { useEffect, useRef } from "react";
import { IMessage, useMessage } from "./message";

interface Props {
  messages: IMessage[];
}

export default function InitMessages(props: Props) {
  const initState = useRef(false);
  useEffect(() => {
    if (!initState.current) {
      useMessage.setState(props);
    }
    initState.current = true;
    return;
  }, [props]);
  return <></>;
}
