import LoginButtons from "@/components/auth/login_buttons";
import SocialLoginButton from "@/components/auth/social_login_button";
import { InitUserState } from "@/lib/store/user/init_user_state";

import getSupbaseServer from "@/lib/supabase/server";

export default async function Page() {  
  // 인증정보 및 유저정보 가져오기
  const supabase = getSupbaseServer();
  const sessionUser = await supabase.auth
    .getUser()
    .then((res) => res.data.user);

  return (
    <main className="max-w-3xl mx-auto md:py-10 h-screen">
      <div>
        <h1 className="text-xl">로그인 페이지</h1>
        <span>채팅을 위해서 로그인을 먼저 진행해주세요</span>
      </div>

      <LoginButtons/>

      {/* 현재 유저 상태 */}
      <InitUserState sessionUser={sessionUser} />
    </main>
  );
}
