"use client";

import React, { useCallback, useEffect, useMemo, useState } from "react";
import { Modal, ModalContent, ModalHeader, ModalBody } from "@nextui-org/react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faComment } from "@fortawesome/free-solid-svg-icons";
import PostCommentInput from "./post-comment-input";

import PostCommentList from "./post-comment-list";
import { createCommentChannel } from "@/lib/supabase/action/create-channel";
import findByUserId from "@/lib/supabase/action/find-by-user-id";
import removeSupbaseChannel from "@/lib/supabase/action/remove_channel";
import axios from "axios";
import { NextEndPoint } from "@/lib/contant/end-point";
import { toast } from "react-toastify";
import { PostComment, PostCommentWithAuthor, PostWithAuthor } from "@/lib/contant/post";

interface Props {
  post: PostWithAuthor;
  size?: "md" | "xl" | "2xl" | "3xl";
  isOpen: boolean;
  onOpenChage: () => void;
}

export default function PostCommentModal(props: Props) {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [comments, setComments] = useState<PostCommentWithAuthor[]>([]);

  const channel = createCommentChannel({
    postId: props.post.id,
    callback: async (payload: { new: any }) => {
      const postComment = payload.new as PostComment;
      const author = await findByUserId({
        userId: postComment.created_by,
      });
      const postCommentWithAuthor = {
        ...payload.new,
        author: {
          id: author?.id ?? "",
          nickname: author?.nickname ?? "",
          profile_image: author?.profile_image ?? "",
        },
      } as PostCommentWithAuthor;
      setComments([postCommentWithAuthor, ...comments]);
    },
  });

  const fetchInitComments = useCallback(async () => {
    setIsLoading(true);
    try {
      await axios
        .get(NextEndPoint.fetchPostComments, {
          params: {
            post_id: props.post.id,
            page: 1,
            size: 20,
          },
        })
        .then((res) => res.data.payload)
        .then(setComments)
        .catch((error) => {
          console.error(error);
          toast.error("Fail to get message");
        });
    } catch (error) {
      console.error(error);
      toast.error("Unknown error");
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchInitComments();
  }, []);

  useEffect(() => {
    return () => {
      removeSupbaseChannel({ channel });
    };
  }, []);

  return (
    <Modal
      className="w-full mx-2 my-2 shadow-lg"
      size={props.size ?? "2xl"}
      isOpen={props.isOpen}
      onOpenChange={props.onOpenChage}
      placement="top-center"
      backdrop="blur"
    >
      <ModalContent>
        {(onClose) => (
          <>
            <ModalHeader className="flex flex-col gap-y-3">
              {/* 헤더 */}
              <div className="flex justify-start items-center gap-x-2">
                <i>
                  <FontAwesomeIcon icon={faComment} />
                </i>
                <h1 className="text-xl font-bold"> COMMENT</h1>
              </div>
              {/* 댓글작성 */}
              <div className="p-1 w-full">
                <PostCommentInput post={props.post} />
              </div>
            </ModalHeader>

            {/* 댓글 목록 */}
            <ModalBody
              className="overflow-y-auto"
              style={{ maxHeight: "80vh" }}
            >
              {isLoading ? (
                <h1>Loadings...</h1>
              ) : (
                <PostCommentList post={props.post} comments={comments} />
              )}
            </ModalBody>
          </>
        )}
      </ModalContent>
    </Modal>
  );
}
