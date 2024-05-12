"use client";

import { useEffect, useRef } from "react";
import { IMessage, useMessage } from "./message";

interface Props {
  messages: IMessage[];
}

export default function InitMessages(props: Props) {
  const initState = useRef(false);
  const { addAllMessage, size, setIsEnd } = useMessage();

  useEffect(() => {
    if (!initState.current) {
      addAllMessage(props.messages);
      setIsEnd(props.messages.length < size);
    }
    initState.current = true;
    return;
  }, [props]);
  return <></>;
}
