import GoogleAuthButton from "@/components/auth/google_auth_button";
import { User } from "@supabase/supabase-js";

interface Props {
  user: User | null;
}

export default function ChatNavbar(props: Props) {
  return (
    <section className="bg-slate-700 p-3">
      <div>
        <div className="flex justify-between items-center">
          <div>
            <div className="flex text-white">NICKNAME</div>
            <div className="flex">
              <div className="h-5 w-5 bg-green-500 rounded-full animate-pulse flex"></div>
              <div className="ml-2 text-sm text-slate-300 flex">STATUS</div>
            </div>
          </div>
          <div>
            <GoogleAuthButton {...props} />
          </div>
        </div>
      </div>
    </section>
  );
}
