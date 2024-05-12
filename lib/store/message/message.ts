import { create } from "zustand";
import { IUser } from "../user/user";

export type IMessage = {
  content: string;
  created_at: string;
  created_by: string;
  id: string;
  removed_at: string | null;
  user: IUser | null;
};

interface MessageState {
  users: IUser[];
  addUser: (user: IUser) => void;
  messages: IMessage[];
  addMessage: (message: IMessage) => void;
  softDeleteMessage: ({
    messageId,
    removedAt,
  }: {
    messageId: string;
    removedAt: string;
  }) => void;
  actionMessage: IMessage | undefined;
  setActionMessage: (actionMessage: IMessage | undefined) => void;
}

export const useMessage = create<MessageState>()((set) => ({
  users: [],
  addUser: (user) => set((state) => ({ users: [...state.users, user] })),
  messages: [],
  actionMessage: undefined,
  addMessage: (newMessage) =>
    set((state) => {
      let newUsers = [...state.users];
      const userIds = state.users.map((u) => u.id);
      if (newMessage?.user?.id && !userIds.includes(newMessage?.user.id)) {
        newUsers.push(newMessage.user);
      }
      return { messages: [...state.messages, newMessage], users: newUsers };
    }),
  softDeleteMessage: ({
    messageId,
    removedAt,
  }: {
    messageId: string;
    removedAt: string;
  }) =>
    set((state) => {
      return {
        messages: state.messages.map((message) =>
          // soft delete
          message.id == messageId
            ? { ...message, removed_at: removedAt }
            : message
        ),
      };
    }),
  setActionMessage: (actionMessage) => set(() => ({ actionMessage })),
}));
