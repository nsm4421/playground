"use client";

import { CommentData } from "@/util/model";

export default function CommentItemComponent(props: {
  comment: CommentData;
  isLoading: boolean;
}) {
  return (
    <div className="p-2 m-2 shadow-sm dark:shadow-slate-500">
      <p className="text-md">{props.comment.content}</p>
      <div className="text-sm mt-1 text-gray-600 dark:text-gray-400 flex justify-between">
        <span>{props.comment.nickname}</span>
        <span>{`last modified at ${props.comment.updatedAt}`}</span>
      </div>
    </div>
  );
}
