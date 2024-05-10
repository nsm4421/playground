import GoogleAuthButton from "@/components/atom/google_auth_button";
import getSupbaseServer from "@/lib/supabase/server";

export default async function Page() {
  const supabase = getSupbaseServer();
  
  const { data } = await supabase.auth.getUser();

  return (
    <main className="max-w-3xl mx-auto md:py-5 h-screen">
      <section className="h-full border rounded-md">
        <div className="px-5 py-3">
          <div>
            <div className="flex justify-between items-center">
              <div>
                <div className="flex">NICKNAME</div>
                <div className="flex">
                  <div className="h-5 w-5 bg-green-500 rounded-full animate-pulse flex"></div>
                  <div className="ml-2 text-sm text-slate-500 flex">STATUS</div>
                </div>
              </div>
              <div>
                <GoogleAuthButton currentUser={data.user} />
              </div>
            </div>
          </div>
        </div>
      </section>

      <section></section>
    </main>
  );
}
