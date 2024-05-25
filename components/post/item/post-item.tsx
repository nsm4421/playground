"use client";

import { PostWithAuthor } from "@/lib/contant/post";
import {
  faComment,
  faHeart,
  faRetweet,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useDisclosure } from "@nextui-org/react";

import PostCommentModal from "../comment/post-comment-modal";
import PostItemContent from "./post-item-content";

interface Props {
  post: PostWithAuthor;
}

export default function PostItem({ post }: Props) {
  const { isOpen, onOpen, onOpenChange } = useDisclosure();

  // TODO
  const handleClickLike = () => {};
  const handleClickRetweet = () => {};

  return (
    <div className="mx-2 my-3 py-3 bg-slate-200 dark:bg-slate-700 rounded-lg">
      <PostItemContent post={post} />

      <ul className="mx-5 gap-x-3 flex">
        {/* 좋아요 버튼 */}
        <i className="p-1 rounded-full">
          <FontAwesomeIcon icon={faHeart} onClick={handleClickLike} />
        </i>
        {/* 댓글 버튼 */}
        <i className="p-1 rounded-full">
          <FontAwesomeIcon icon={faComment} onClick={onOpen} />
        </i>
        {/* 공유 버튼 */}
        <i className="p-1 rounded-full">
          <FontAwesomeIcon icon={faRetweet} onClick={handleClickRetweet} />
        </i>
      </ul>

      {/* 댓글창 */}
      {isOpen && (
        <PostCommentModal
          post={post}
          isOpen={isOpen}
          onOpenChage={onOpenChange}
        />
      )}
    </div>
  );
}
