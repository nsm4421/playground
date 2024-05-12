import ChatInput from "@/components/chat/chat_input";
import ChatMessageListWraaper from "@/components/chat/chat_messages_list_wrapper";
import ChatNavbar from "@/components/navbar/chat_navbar";
import { InitUserState } from "@/lib/store/user/init_user_state";
import { IUser } from "@/lib/store/user/user";

import getSupbaseServer from "@/lib/supabase/server";

export default async function Page() {

  // 인증정보 및 유저정보 가져오기
  const supabase = getSupbaseServer();
  let sessionUser = await supabase.auth.getUser().then((res) => res.data.user);
  let currentUser = null;
  if (sessionUser != null) {
    currentUser = await supabase
      .from("users")
      .select("*")
      .eq("id", sessionUser.id)
      .single()
      .then((res) => res.data as IUser | null);
  }

  return (
    <main className="max-w-3xl mx-auto md:py-10 h-screen">
      <div className=" h-full border rounded-md flex flex-col">
        <ChatNavbar user={sessionUser} />
        <ChatMessageListWraaper />
        <div className="p-5">
          <ChatInput />
        </div>
      </div>
      {/* 현재 유저 상태 */}
      <InitUserState sessionUser={sessionUser} currentUser={currentUser} />
    </main>
  );
}
