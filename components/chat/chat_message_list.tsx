"use client";

import { IMessage, useMessage } from "@/lib/store/message/message";
import Image from "next/image";

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

function ChatMesssageItem({ message }: { message: IMessage }) {
  const dt = new Date(message.created_at).toDateString();

  return (
    <>
      {/* 프로필 이미지 */}
      <div className="w-10 h-10">
        {message.user?.profile_image && (
          <Image
            width={30}
            height={30}
            src={message.user?.profile_image}
            alt={message.user.id}
            className="rounded-full"
          />
        )}
      </div>

      <div className="flex-1">
        <div className="flex items-center gap-1">
          <p className="font-bold">{message.user?.username}</p>
          <p className="text-sm text-gray-400">{dt}</p>
        </div>
        <p className="text-black dark:text-gray-300">{message.content}</p>
      </div>
    </>
  );
}
