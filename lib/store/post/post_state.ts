import { PostWithAuthor } from "@/lib/contant/post";
import { create } from "zustand";

interface PostState {
  posts: PostWithAuthor[];
  page: number;
  size: number;
  addPosts: (newPosts: PostWithAuthor[]) => void;
}

const usePostState = create<PostState>()((set) => ({
  posts: [],
  page: 1,
  size: 20,
  addPosts: (newPosts: PostWithAuthor[]) =>
    set((state) => ({ posts: [...state.posts, ...newPosts] })),
}));

export default usePostState;
