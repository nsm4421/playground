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
    </main>
  );
}
