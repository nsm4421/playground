import { User } from "@supabase/auth-js";
import { create } from "zustand";

export type BasicUser = {
  id: string;
  username: string;
  avatar_url: string | null;
  created_at : string | undefined;
};

type UserState = {
  basicUser : BasicUser | null;
  sessionUser: User | null;
};

export const useUser = create<UserState>()((set) => ({
  basicUser:null,
  sessionUser: null,
}));
