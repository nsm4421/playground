"use client";

import { PostData } from "@/util/model";
import { useEffect, useState } from "react";
import PostComponent from "./post-component";
import axios from "axios";
import PaginationComponent from "./pagination-component";
import { useParams } from "next/navigation";

export default function PostListComponent() {
  const params = useParams();
  // const router = useRouter()
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [posts, setPosts] = useState<PostData[]>([]);
  const [page, setPage] = useState<number>(1);
  const [totalCount, setTotalCount] = useState<number>(0);
  const fetchPost = async () => {
    setIsLoading(true);
    await axios
      .get(`/api/post?page=${page??1}&limit=${10}`)
      .then((res) => res.data.data)
      .then((data: { posts: PostData[]; totalCount: number }) => {
        setPosts(data.posts);
        setTotalCount(data.totalCount);
      })
      .finally(() => setIsLoading(false));
  };

  useEffect(() => {
    fetchPost();
  }, [page]);

  return (
    <div className="relative overflow-x-auto shadow-md sm:rounded-lg">
      {/* Pagination */}
      <div>
        <PaginationComponent
          page={page}
          setPage={setPage}
          totalCount={totalCount}
          limit={10}
        />
      </div>
      {/* Post List */}
      <table className="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead className="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" className="px-6 py-3 text-center">
              Title
            </th>
            <th scope="col" className="px-6 py-3 text-center">
              Content
            </th>
            <th scope="col" className="px-6 py-3 text-center">
              Author
            </th>
            <th scope="col" className="px-6 py-3 text-center">
              Create At
            </th>
            <th scope="col" className="px-6 py-3 text-center">
              <span className="sr-only">Edit</span>
            </th>
          </tr>
        </thead>
        <tbody>
          {posts &&
            posts.map((post: PostData, idx) => (
              <PostComponent key={idx} post={post} fetchPost={fetchPost}/>
            ))}
        </tbody>
      </table>
    </div>
  );
}
