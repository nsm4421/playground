import GoogleAuthButton from "@/components/atom/google_auth_button";
import ChatNavbar from "@/components/component/navbar/chat_navbar";
import { Input } from "@/components/ui/input";
import InitUserState from "@/lib/store/user/init_user_state";
import getSupbaseServer from "@/lib/supabase/server";

export default async function Page() {
  const supabase = getSupbaseServer();

  const { data } = await supabase.auth.getUser();

  return (
    <main className="max-w-3xl mx-auto md:py-10 h-screen">
      <div className=" h-full border rounded-md flex flex-col">
        <ChatNavbar currentUser={data.user} />
        <div className="flex-1 flex flex-col p-5 h-full overflow-y-auto">
          <div className="flex-1 "></div>
          <div className=" space-y-7">
            {[1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12].map((value) => {
              return (
                <div className="flex gap-2" key={value}>
                  <div className="h-10 w-10 bg-green-500 rounded-full"></div>
                  <div className="flex-1">
                    <div className="flex items-center gap-1">
                      <p className="font-bold">Sokheng</p>
                      <p className="text-sm text-gray-400">
                        {new Date().toDateString()}
                      </p>
                    </div>
                    <p className="text-gray-300">
                      Displays a form input field or a component that looks like
                      an input field.Displays a form input field or a component
                      that looks like an input field.
                    </p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
        <div className="p-5">
          <Input placeholder="send message" />
        </div>
      </div>
      {/* 현재 인증 상태 */}
      <InitUserState user={data.user} />
    </main>
  );
}
