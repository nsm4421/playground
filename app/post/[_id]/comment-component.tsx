"use client";

import { useParams } from "next/navigation";
import WriteCommentComponent from "./write-comment-component";
import { useEffect, useState } from "react";
import useAxios from "@/util/hook/use-axios";
import PaginationAtom from "@/components/atom/pagination-atom";
import { CommentData } from "@/util/model";
import CommentItemComponent from "./comment-item-component";

export default function CommentComponent() {
  const params = useParams();
  const [page, setPage] = useState<number>(1);
  const { data, isLoading, refetch } = useAxios({
    url: `/api/post/comment?postId=${params._id}&page=${page}&limit=${10}`,
  });

  const handlePageChange = async () => {
    if (!params._id) return;
    await refetch();
  };
  useEffect(() => {
    handlePageChange();
    return;
  }, [page]);

  return (
    <div>
      <WriteCommentComponent refetch={refetch} />

      <span className="text-sm p-2 m-2">Pagination</span>

      {!isLoading && (
        <PaginationAtom
          isLoading={isLoading}
          page={page}
          setPage={setPage}
          limit={10}
          totalCount={data.data.totalCount}
        />
      )}

      {/* Comment List */}
      <div>
        {!isLoading &&
          data?.data.comments &&
          data?.data.comments.map((comment: CommentData, idx: number) => (
            <CommentItemComponent
              key={idx}
              comment={comment}
              isLoading={isLoading}
            />
          ))}
      </div>
    </div>
  );
}
