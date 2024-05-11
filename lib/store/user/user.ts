import { User } from "@supabase/auth-js";
import { create } from "zustand";

export interface IUser {
  created_at: string;
  email: string;
  id: string;
  profile_image: string | null;
  removed_at: string | null;
  username: string;
}

type UserState = {
  currentUser: IUser | null;
  sessionUser: User | null;
};

export const useUser = create<UserState>()((set) => ({
  currentUser: null,
  sessionUser: null,
}));
