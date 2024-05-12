import getSupabaseServer from "@/lib/supabase/server";
import { Suspense } from "react";
import ChatMessageList from "./chat_message_list";
import InitMessages from "@/lib/store/message/init_messages";
import { useMessage } from "@/lib/store/message/message";

export default async function ChatMessageListWraaper() {
  const supabase = getSupabaseServer();
  const { size } = useMessage();

  const { data } = await supabase
    .from("messages")
    .select("*,user:users(*)")
    .range(0, size)
    .order("created_at", { ascending: false });

  return (
    <Suspense fallback={"로딩중입니다..."}>
      <ChatMessageList />
      <InitMessages messages={data?.reverse() || []} />
    </Suspense>
  );
}
