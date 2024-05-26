import { PostWithAuthor } from "@/lib/contant/post";
import { create } from "zustand";

interface PostState {
  // state
  posts: PostWithAuthor[]; // 현재 조회한 포스팅 목록
  page: number; // 현재 페이지수
  size: number; // 현재 페이지당 게시글 수
  isEnd: boolean; // 마지막 페이지 여부
  isFetching: boolean; // 로딩중 여부

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
  size: 2,
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
