import { InitUserState } from "@/lib/store/user/init_user_state";

import getSupbaseServer from "@/lib/supabase/server";
import Link from "next/link";

export default async function Page() {

  // 인증정보 및 유저정보 가져오기
  const supabase = getSupbaseServer();
  const sessionUser = await supabase.auth.getUser().then((res) => res.data.user);

  return (
    <main className="max-w-3xl mx-auto md:py-10 h-screen">
      <div className=" h-full border rounded-md flex flex-col">
        <Link href={"/chat"}>CHAT</Link>
      </div>
      {/* 현재 유저 상태 */}
      <InitUserState sessionUser={sessionUser}/>
    </main>
  );
}
