"use client";

import usePostState from "@/lib/store/post/post_state";
import PostItem from "./item/post-item";

export default function PostList() {
  const { posts, isEnd, isFetching, page, setPage } = usePostState();

  const handleIncreasePage = () => setPage(page + 1);

  // 포스팅이 없는 경우
  if (posts.length === 0) {
    return <h1>No Post Founded...</h1>;
  }

  // 포스팅이 존재하는 경우
  return (
    <div className="flex flex-col gap-y-2">
      {/* 포스팅 목록 */}
      <ul>
        {posts.map((post, index) => (
          <li key={index}>
            <PostItem post={post} />
          </li>
        ))}
      </ul>

      <div className="flex justify-center text-slate-500 font-bold">
        {/* 로딩중 */}
        {isFetching && <h1>Loadings...</h1>}

        {/* 마지막 페이지 인 경우 */}
        {isEnd && <h1>Last Page</h1>}

        {/* 더 가져오기 버튼  : page변수를 증가시키면 InitPost 컴퍼넌트에서 자동으로 포스팅 목록을 가져도록 함 */}
        {!isEnd && !isFetching && (
          <h1 onClick={handleIncreasePage}>Get More</h1>
        )}
      </div>
    </div>
  );
}
