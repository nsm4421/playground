"use client";

import { useMessage } from "@/lib/store/message/message";
import ChatMesssageItem from "./chat_message_item";


export default function ChatMessageList() {
  const messages = useMessage((state) => state.messages);

  return (
    <div className="space-y-7">
      {messages.map((message, index) => (
        <div className="flex gap-2" key={index}>
          <ChatMesssageItem message={message} />
        </div>
      ))}
    </div>
  );
}