import PostList from "@/components/post/post-list";
import InitPost from "@/lib/store/post/init_post";
import { faPencil, faSearch } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Link from "next/link";

export default function Page() {
  return (
    <main>
      <ul>
        <li className="hover:bg-orange-500 hover:text-white rounded-lg p-2 flex w-fit">
          <Link
            href={"/post/create"}
            className="text-xl font-bold gap-x-2 flex items-center"
          >
            Write
          </Link>
        </li>

        {/* TODO : 검색페이지 구현 */}
        <li className="hover:bg-orange-500 hover:text-white rounded-lg p-2 flex w-fit">
          <Link
            href={"/post/search"}
            className="text-xl font-bold gap-x-2 flex items-center"
          >
            Search
          </Link>
        </li>
      </ul>

      {/* 포스팅 목록 */}
      <PostList />

      {/* 포스팅 목록 초기화 */}
      <InitPost />
    </main>
  );
}
