"use client";

import { useMessage } from "@/lib/store/message/message";
import { Button } from "../ui/button";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { toast } from "sonner";
import { useState } from "react";

export default function LoadChatMessage() {
  const [isLoading, setIsLoading] = useState(false);
  const supabase = getSupbaseBrowser();

  const { page, size, isEnd, setIsEnd, addAllMessage, setPage } = useMessage();

  const fetchMessages = async () => {
    try {
      setIsLoading(true);
      const { data, error } = await supabase
        .from("messages")
        .select("*,user:users(*)")
        .range((page - 1) * size, page * size - 1)
        .order("created_at", { ascending: false });
      if (error) {
        toast.error(error.message);
        console.error(error);
      } else if (data.length < size) {
        setIsEnd(true);
      } else {
        setIsEnd(false);
        addAllMessage(data.reverse());
        setPage(page + 1);
      }
    } catch (err) {
      toast.error("메세지를 가져오기 실패");
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      {isEnd ? (
        <span className="w-full text-slate-300 dark:text-gray-600">
          No more messages...
        </span>
      ) : (
        <Button
          variant="outline"
          className={`w-full ${isLoading ? "cursor-wait" : "cursor-pointer"}`}
          onClick={fetchMessages}
          disabled={isLoading}
        >
          {isLoading ? "로딩중..." : " 더 가져오기"}
        </Button>
      )}
    </>
  );
}
