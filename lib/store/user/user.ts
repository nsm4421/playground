import { User } from "@supabase/auth-js";
import { create } from "zustand";

interface UserState {
  user: User | null;
}

const userStore = create<UserState>()((set) => ({
  user: null,
  inc: () => set((state) => ({ user: null })),
}));

export default userStore;
