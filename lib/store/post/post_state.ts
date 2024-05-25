import { PostWithAuthor } from "@/lib/contant/post";
import { create } from "zustand";

interface PostState {
  // state
  posts: PostWithAuthor[];
  page: number;
  size: number;
  isEnd: boolean;
  isFetching: boolean;

  // setter
  setIsEnd: (isEnd: boolean) => void;
  setPage: (page: number) => void;
  setIsFetching: (isFetching: boolean) => void;

  // callback
  addPosts: (newPosts: PostWithAuthor[]) => void;
}

const usePostState = create<PostState>()((set) => ({
  // state
  posts: [],
  page: 1,
  size: 20,
  isEnd: false,
  isFetching: false,

  // setter
  setIsEnd: (isEnd: boolean) => set(() => ({ isEnd })),
  setPage: (page: number) => set(() => ({ page })),
  setIsFetching: (isFetching: boolean) => set(() => ({ isFetching })),

  // callback
  addPosts: (newPosts: PostWithAuthor[]) =>
    set((state) => {
      // 중복제거
      const postIds = state.posts.map((post) => post.id);
      const postsToAdd = newPosts.filter((post) => !postIds.includes(post.id));
      // append
      return { posts: [...state.posts, ...postsToAdd] };
    }),
}));

export default usePostState;
