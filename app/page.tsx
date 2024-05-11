import ChatInput from "@/components/chat/chat_input";
import ChatMessageListWraaper from "@/components/chat/chat_messages_list_wrapper";
import ChatNavbar from "@/components/navbar/chat_navbar";
import { InitUserState } from "@/lib/store/user/init_user_state";
import { IUser } from "@/lib/store/user/user";

import getSupbaseServer from "@/lib/supabase/server";

export default async function Page() {
  const supabase = getSupbaseServer();
  let sessionUser = await supabase.auth.getUser().then((res) => res.data.user);
  let currentUser = null;
  if (sessionUser != null) {
    currentUser = await supabase
      .from("users")
      .select("*")
      .eq("id", sessionUser.id)
      .then((res) => (res.data ? (res.data[0] as IUser) : null));
  }

  return (
    <main className="max-w-3xl mx-auto md:py-10 h-screen">
      <div className=" h-full border rounded-md flex flex-col">
        <ChatNavbar user={sessionUser} />
        <div className="flex-1 flex flex-col p-5 h-full overflow-y-auto">
          <div className="flex-1 "></div>
          <ChatMessageListWraaper />
        </div>
        <div className="p-5">
          <ChatInput />
        </div>
      </div>
      {/* 현재 유저 상태 */}
      <InitUserState sessionUser={sessionUser} currentUser = {currentUser}/>
    </main>
  );
}
