"use client";

import { useEffect, useRef } from "react";
import { IMessage, useMessage } from "./message";
import { PAGE_SIZE } from "@/lib/const/constant";

interface Props {
  messages: IMessage[];
}

export default function InitMessages(props: Props) {
  const initState = useRef(false);
  const { addAllMessage, setIsEnd } = useMessage();

  useEffect(() => {
    if (!initState.current) {
      addAllMessage(props.messages);
      setIsEnd(props.messages.length < PAGE_SIZE);
    }
    initState.current = true;
    return;
  }, [props]);
  return <></>;
}
