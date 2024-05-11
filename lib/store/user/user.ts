import { User } from "@supabase/auth-js";
import { create } from "zustand";

interface UserState {
  user: User | null;
}

export const useUser = create<UserState>()((set) => ({
  user: null,
}));
