import { create } from "zustand";

export type IMessage = {
  content: string;
  created_at: string;
  created_by: string;
  id: string;
  is_edit: boolean;
  removed_at: string | null;
  user: {
    created_at: string;
    id: string;
    profile_image: string | null;
    removed_at: string | null;
    username: string;
  } | null;
};

interface MessageState {
  messages: IMessage[];
  addMessage: (message: IMessage) => void;
}

export const useMessage = create<MessageState>()((set) => ({
  messages: [],
  addMessage: (newMessage) =>
    set((state) => ({ messages: [...state.messages, newMessage] })),
}));
