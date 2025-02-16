import { User } from "./user";

export type Feed = {
  id: string;
  content: string;
  user: User;
  images: string[];
  createdAt: string;
};
