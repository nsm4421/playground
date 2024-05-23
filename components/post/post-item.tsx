"use client";

import { PostWithAuthor } from "@/lib/contant/post";
import {
  faComment,
  faHeart,
  faRetweet,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Avatar, Chip, Input, useDisclosure } from "@nextui-org/react";
import { Carousel } from "flowbite-react";
import Image from "next/image";
import PostCommentModel from "./comment/post-comment-modal";
import dateFormatUtil from "@/lib/util/date-format-util";

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
      <div className="flex justify-between items-center px-3">
        {/* 유저 아바타 */}
        <div className="flex items-center gap-x-2">
          <Avatar src={post.author.profile_image} name={"?"} />
          <h3 className="text-medium text-slate-500">{post.author.nickname}</h3>
        </div>
        {/* 작성시간 */}
        {post.created_at && <span>{dateFormatUtil(post.created_at)}</span>}
      </div>

      {/* Carousel */}
      {post.images && (
        <figure className="h-56 sm:h-96 xl:h-120 2xl:h-144 rounded-lg my-3 w-full">
          <Carousel
            slideInterval={5000}
            slide={false}
            draggable={false}
            indicators={false}
          >
            {post.images.map((image, index) => (
              <Image
                src={image}
                alt={`${post.id}-${index}th-image`}
                key={index}
                width={300}
                height={300}
              />
            ))}
          </Carousel>
        </figure>
      )}

      {/* 본문 */}
      <article className="text-xl mx-1 px-2 my-3">{post.content}</article>

      {/* 해시태그 */}
      {post.hashtags.length > 0 && (
        <ul className="my-3 flex gap-x-2 mx-3">
          {post.hashtags.map((hashtag, index) => (
            <li key={index}>
              <Chip className="hover:bg-orange-400">
                <label>{hashtag}</label>
              </Chip>
            </li>
          ))}
        </ul>
      )}

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
      <PostCommentModel
        postId={post.id}
        isOpen={isOpen}
        onOpenChage={onOpenChange}
      />
    </div>
  );
}
