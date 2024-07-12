import PostList from "@/components/post/post-list";
import InitPost from "@/lib/store/post/init-post";
import { faPencil, faSearch } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Link from "next/link";

export default function Page() {
  return (
    <main>
      <div className="flex justify-between items-center mx-2 mt-5">
        <h1 className="text-2xl font-bold gap-x-2 flex items-center">POST</h1>

        <ul className="flex gap-x-3 items-center">
          <li className="hover:bg-orange-500 hover:text-white rounded-full w-8 h-8 justify-center items-center flex">
            <Link href={"/post/create"} className="justify-center items-center">
              <i>
                <FontAwesomeIcon icon={faPencil} />
              </i>
            </Link>
          </li>
          <li className="hover:bg-orange-500 hover:text-white rounded-full w-8 h-8 justify-center items-center flex">
            <Link href={"/post/search"}>
              <i>
                <FontAwesomeIcon icon={faSearch} />
              </i>
            </Link>
          </li>
        </ul>
      </div>

      {/* 포스팅 목록 */}
      <PostList />

      {/* 포스팅 목록 초기화 */}
      <InitPost />
    </main>
  );
}
