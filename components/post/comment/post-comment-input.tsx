"use client";

import { NextEndPoint } from "@/lib/contant/end-point";
import { PostWithAuthor } from "@/lib/contant/post";
import { faPaperPlane } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Input } from "@nextui-org/react";
import axios from "axios";
import { useState } from "react";
import { toast } from "react-toastify";
import { v4 } from "uuid";

interface Props {
  post: PostWithAuthor;
}

export default function PostCommentInput({ post }: Props) {
  const maxLength = 500;

  const [content, setContent] = useState<string>("");
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleSubmitComment = async () => {
    try {
      setIsLoading(true);
      await axios
        .post(NextEndPoint.createPostComment, {
          id: v4(),
          content,
          post_id: post.id,
        })
        .then(console.log);
      setContent("");
    } catch (error) {
      console.error(error);
      toast.error("Fail!");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Input
      value={content}
      onValueChange={setContent}
      maxLength={maxLength}
      placeholder="Write Comment"
      // 댓글 제출 버튼
      endContent={
        <button
          disabled={isLoading}
          className={`rounded-full hover:bg-orange-500 w-10 h-10 p-1 ${
            isLoading ? "hover:cursor-wait" : "hover:cursor-pointer"
          }`}
          onClick={handleSubmitComment}
        >
          <FontAwesomeIcon icon={faPaperPlane} />
        </button>
      }
    />
  );
}
