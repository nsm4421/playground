import SignOutAction from "@/lib/supabase/action/sign-out";
import createSupabaseBrowerCleint from "@/lib/supabase/client/browser-client";
import { User } from "@supabase/supabase-js";
import { create } from "zustand";

interface CurrentUserState {
  user: User | null;
  setUser: (user: User | null) => void;
  signOut: () => Promise<void>;
}

const useAuth = create<CurrentUserState>()((set) => ({
  user: null,
  setUser: (user: User | null) => set(() => ({ user })),
  signOut: async () => {
    await SignOutAction()
      .then(() => {
        set(() => ({ user: null }));
      })
      .catch(console.error);
  },
}));

export default useAuth;
