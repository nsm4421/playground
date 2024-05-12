"use client";

import { IMessage, useMessage } from "@/lib/store/message/message";
import ChatMesssageItem from "./chat_message_item";
import { useEffect, useRef, useState } from "react";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { toast } from "sonner";
import { IUser } from "@/lib/store/user/user";
import { ArrowDown } from "lucide-react";

export default function ChatMessageList() {
  const supabase = getSupbaseBrowser();
  const { users, addUser, messages, addMessage, softDeleteMessage } =
    useMessage((state) => state);
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
          if (!userIds.includes(payload.new.user.id)) {
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
              addUser(data as IUser);
            }
          }
          const user = users.find((u) => u.id === payload.new.created_by);

          // 메세지 추가
          const newMessage = {
            content: payload.new.content,
            created_at: payload.new.created_at,
            created_by: payload.new.created_by,
            id: payload.new.id,
            removed_at: payload.new.removed_at,
            user: user,
          };
          addMessage(newMessage as IMessage);
        }
      )
      // 메세지 삭제
      .on(
        "postgres_changes",
        {
          event: "DELETE",
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

  /// 메세지를 수신 시, 스크롤이 맨 아래 있는 경우, 스크롤 바 맨 아래로 내리기
  useEffect(() => {
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
        {messages.map((message, index) => (
          <div className="flex gap-2" key={index}>
            <ChatMesssageItem message={message} />
          </div>
        ))}
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
