"use client";

import { PostData } from "@/util/model";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useSession } from "next-auth/react";
import IconButtonAtom from "@/components/atom/icon-button-atom";
import { ArrowUpRightIcon } from "@heroicons/react/24/outline";


export default function PostComponent(props: {
  post: PostData;
  fetchPost: Function;
}) {
  const router = useRouter();
  const session = useSession();
  const goToDetailPage = (postId: string) => () =>
    router.push(`/post/${postId}`);
  return (
    <>
      <tr className="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
        <th
          onClick={goToDetailPage(props.post.postId)}
          scope="row"
          className="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white text-center"
        >
          <IconButtonAtom label={props.post.title} icon={<ArrowUpRightIcon className="w-4 h-4"/>} disabled={false}/>
        </th>
        <td className="px-6 py-4 text-center">{props.post.content}</td>
        <td className="px-6 py-4 text-center">{props.post.nickname}</td>
        <td className="px-6 py-4 text-center">{props.post.createdAt}</td>
        <td className="px-6 py-4 text-center">
          {/* if login user and author are equal, then show edit, delete button */}
          {props.post?.userId === session.data?.user?.id && (
            <GoToEditPage {...props} />
          )}
        </td>
      </tr>
    </>
  );
}

function GoToEditPage(props: { post: PostData }) {
  return (
    <Link href={`/post/edit/${props.post.postId}`}>
      <button
        type="button"
        className="text-gray-900 bg-white hover:bg-gray-100 border border-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:focus:ring-gray-600 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700 mr-2 mb-2"
      >
        <span className="text-sm">Edit</span>
      </button>
    </Link>
  );
}
