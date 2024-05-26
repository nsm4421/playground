import PostList from "@/components/post/post-list";
import PostSearchOption from "@/components/post/search/post-search-option";
import InitPost from "@/lib/store/post/init_post";

export default function Page() {
  return (
    <main>
      {/* 검색 옵션 */}
      <PostSearchOption />

      {/* 포스팅 목록 */}
      <PostList />

      {/* 포스팅 목록 초기화 */}
      <InitPost />
    </main>
  );
}
