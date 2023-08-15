import {
  ArrowRightCircleIcon,
  ArrowLeftCircleIcon,
} from "@heroicons/react/24/outline";
import { useRouter } from "next/navigation";
import { Dispatch, SetStateAction } from "react";

/**
 *
 * @param page current page
 * @param setPage
 * @param limt number of element per size
 * @param totalCount number of total elements
 * @param isLoading loading중 여부
 * @returns
 */
export default function PaginationAtom(props: {
  page: number;
  setPage: Dispatch<SetStateAction<number>>;
  limit: number;
  totalCount: number;
  isLoading?: boolean;
  href?:string;
}) {
  const router = useRouter();
  const minPage = Math.max(props.page - Math.floor(props.limit / 2), 1);
  const maxPage = Math.min(
    props.page + Math.floor(props.limit / 2),
    Math.ceil(props.totalCount / props.limit)
  );
  const handleOnClick = (page: number) => async () => {
    if (page < minPage || page > maxPage) return;
    await props.setPage(page);
    if (props.href) router.push(`${props.href}?page=${page}`)
  };
  const clsName =
    "px-3 leading-tight text-gray-500 bg-white border-gray-300 hover:text-green-600 hover:bg-green-400 hover:text-gray-400 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-green-500";
  const clsNameActive = `${clsName} ${"text-blue-600 dark:text-blue-400"}`;

  return (
    <ul className="cursor-pointer inline-flex items-center -space-x-px align-middle">
      <li className="px-3">
        <button
          className="cursor-pointer hover:text-green-500"
          disabled={props.page <= 1 && props.isLoading}
          onClick={handleOnClick(props.page - 1)}
        >
          <ArrowLeftCircleIcon className="h-4 w-4" />
        </button>
      </li>

      {Array.from(
        { length: maxPage - minPage + 1 },
        (_, idx) => idx + minPage
      ).map((page) => {
        return (
          <li key={page}>
            <button
              disabled={props.isLoading}
              onClick={handleOnClick(page)}
              className={page === props.page ? clsNameActive : clsName}
            >
              {page}
            </button>
          </li>
        );
      })}

      <li className="px-3">
        <button
          className="cursor-pointer hover:text-green-500"
          disabled={props.page >= maxPage && props.isLoading}
          onClick={handleOnClick(props.page + 1)}
        >
          <ArrowRightCircleIcon className="h-4 w-4" />
        </button>
      </li>
    </ul>
  );
}
