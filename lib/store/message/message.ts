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
  deleteMessageById: (messageIdToDelete: string) => void;
  actionMessage: IMessage | undefined;
  setActionMessage: (actionMessage: IMessage | undefined) => void;
}

export const useMessage = create<MessageState>()((set) => ({
  messages: [],
  actionMessage: undefined,
  addMessage: (newMessage) =>
    set((state) => ({ messages: [...state.messages, newMessage] })),
  deleteMessageById: (messageIdToDelete) =>
    set((state) => {
      return {
        messages: state.messages.filter(
          (message) => message.id != messageIdToDelete
        ),
      };
    }),
  setActionMessage: (actionMessage) => set(() => ({ actionMessage })),
}));
