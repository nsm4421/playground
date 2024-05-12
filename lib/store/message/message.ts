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
  // pagination
  page: number;
  size: number;
  isEnd: boolean;
  setPage: (page: number) => void;
  setIsEnd: (isEnd: boolean) => void;

  // users
  users: IUser[];
  addUser: (user: IUser) => void;

  // messages
  messages: IMessage[];
  addMessage: (message: IMessage) => void;
  addAllMessage: (messages: IMessage[]) => void;
  softDeleteMessage: ({
    messageId,
    removedAt,
  }: {
    messageId: string;
    removedAt: string;
  }) => void;

  // current message
  actionMessage: IMessage | undefined;
  setActionMessage: (actionMessage: IMessage | undefined) => void;
}

export const useMessage = create<MessageState>()((set) => ({
  // pagination
  page: 1,
  size: 20,
  isEnd: false,
  setPage: (page: number) => set(() => ({ page })),
  setIsEnd: (isEnd: boolean) => set(() => ({ isEnd })),

  // users
  users: [],
  addUser: (user) => set((state) => ({ users: [...state.users, user] })),

  // messages
  messages: [],

  addMessage: (newMessage) =>
    set((state) => {
      let newUsers = [...state.users];
      const userIds = state.users.map((u) => u.id);
      if (newMessage?.user?.id && !userIds.includes(newMessage?.user.id)) {
        newUsers.push(newMessage.user);
      }
      return { messages: [...state.messages, newMessage], users: newUsers };
    }),
  addAllMessage: (newMessages) =>
    set((state) => {
      const originalUserIds = state.users.map((u) => u.id);
      const newUsers = Array.from(
        new Set(
          newMessages
            .map((message) => message?.user)
            .filter((user) => user != null)
            .filter((user) => !originalUserIds.includes(user!.id))
        )
      ) as IUser[];
      return {
        users: [...state.users, ...newUsers],
        messages: [...newMessages, ...state.messages],
      };
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
          message.id === messageId
            ? {
                ...message,
                content: "삭제된 메세지 입니다",
                removed_at: removedAt,
              }
            : message
        ),
      };
    }),

  // current message
  actionMessage: undefined,
  setActionMessage: (actionMessage) => set(() => ({ actionMessage })),
}));
