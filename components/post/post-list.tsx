"use client";

import usePostState from "@/lib/store/post/post_state";
import PostItem from "./post-item";

export default function PostList() {
  const { posts, addPosts, page } = usePostState();

  // TODO : 스크롤이 가장 아래로 내려간 경우, 포스트 더 불러오기

  return (
    <ul>
      {posts.map((post, index) => (
        <li key={index}>
          <PostItem post={post} />
        </li>
      ))}
    </ul>
  );
}
