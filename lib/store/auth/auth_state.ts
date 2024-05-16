import { User } from "@supabase/supabase-js";
import { create } from "zustand";

interface CurrentUserState {
  user: User | null;
  setUser: (user: User | null) => void;
}

const useAuth = create<CurrentUserState>()((set) => ({
  user: null,
  setUser: (user: User | null) => set(() => ({ user })),
}));

export default useAuth;
