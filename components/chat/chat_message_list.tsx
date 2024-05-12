"use client";

import { IMessage, useMessage } from "@/lib/store/message/message";
import ChatMesssageItem from "./chat_message_item";
import { useEffect, useRef, useState } from "react";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { toast } from "sonner";
import { ArrowDown } from "lucide-react";
import LoadChatMessage from "./load_chat_message";
import { BasicUser } from "@/lib/store/user/user";

export default function ChatMessageList() {
  const supabase = getSupbaseBrowser();
  const { users, addUser, messages, addMessage, softDeleteMessage } =
    useMessage();
  const scrollRef = useRef() as React.MutableRefObject<HTMLDivElement>;
  const [isAtBottom, setIsAtBottom] = useState(false);

  /// 메세지를 수신/삭제 시, 전역 상태 업데이트
  useEffect(() => {
    const channel = supabase
      .channel("chat-room")
      // 메세지 수신
      .on(
        "postgres_changes",
        {
          event: "INSERT",
          schema: "public",
          table: "messages",
        },
        async (payload) => {
          // 유저 정보 조회
          const userIds = users.map((u) => u.id);
          if (!userIds.includes(payload.new.created_by)) {
            const { data, error } = await supabase
              .from("users")
              .select("*")
              .eq("id", payload.new.created_by)
              .single();
            if (error) {
              toast.error("유저정보 가져오기 실패");
              console.error(error);
              return;
            } else {
              addUser(data as BasicUser);
            }
          }
          const user = users.find((u) => u.id === payload.new.created_by);

          // 메세지 추가
          const newMessage: IMessage = {
            content: payload.new.content,
            created_at: payload.new.created_at,
            id: payload.new.id,
            removed_at: payload.new.removed_at,
            sender: user ?? null,
          };
          addMessage(newMessage);
        }
      )
      // 메세지 삭제
      .on(
        "postgres_changes",
        {
          event: "UPDATE", // soft delete
          schema: "public",
          table: "messages",
        },
        async (payload) => {
          const removedAt = new Date().toISOString();
          softDeleteMessage({ messageId: payload.old.id, removedAt });
        }
      )
      .subscribe();
    return () => {
      channel.unsubscribe();
    };
  }, [messages]);

  useEffect(() => {
    handleScroll();
    if (isAtBottom) {
      handleJumpToBottom();
    }
  }, [messages]);

  const handleJumpToBottom = () => {
    const container = scrollRef.current;
    if (container) {
      container.scrollTop = container.scrollHeight;
    }
  };

  const handleScroll = () => {
    const container = scrollRef.current;
    if (container) {
      setIsAtBottom(
        container.scrollTop >
          container.scrollHeight - container.clientHeight - 10
      );
    }
  };

  return (
    <div
      className="flex-1 flex flex-col p-5 h-full overflow-y-auto"
      ref={scrollRef}
      onScroll={handleScroll}
    >
      {/* 메세지 목록 */}
      <div className="space-y-7">
        {/* 메세지 더 가져오기 버튼 */}
        <div className="my-2">
          <LoadChatMessage />
        </div>
        <ul>
          {messages.map((message, index) => (
            <li className="flex gap-2" key={index}>
              <ChatMesssageItem message={message} />
            </li>
          ))}
        </ul>
      </div>

      {/* 맨 아래로 버튼 */}
      {!isAtBottom && (
        <div className="absolute bottom-20 right-1/2">
          <div className="flex rounded-full cursor-pointer justify-center items-center bg-green-500 w-10 h-10 text-white">
            <ArrowDown
              className="cursor-pointer"
              onClick={handleJumpToBottom}
            />
          </div>
        </div>
      )}
    </div>
  );
}
