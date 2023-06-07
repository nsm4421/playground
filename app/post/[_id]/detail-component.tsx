"use client";

import { useParams } from "next/navigation";
import WriteCommentComponent from "./write-comment-component";
import { CommentData, PostData } from "@/util/model";
import { useEffect, useState } from "react";
import PostContentComponent from "./post-content-component";
import CommentItemComponent from "./comment-item-component";

export default function DetailComponent() {
  const params = useParams();
  const [post, setPost] = useState<PostData | null>(null);
  const [comments, setComments] = useState<CommentData[]>([]);
  const getPost = async (postId: string) => {
    return await fetch(`/api/post?_id=${postId}`)
      .then((res) => res.json())
      .then((data) => data.data);
  };
  const getComments = async (postId: string) => {
    return await fetch(`/api/post/comment?postId=${postId}`)
      .then((res) => res.json())
      .then((data) => data.data);
  };
  useEffect(() => {
    const _init = async () => {
      const postId = await params._id;
      if (!postId) return;
      setPost(await getPost(postId));
      setComments(await getComments(postId));
    };
    _init();
  }, []);

  return (
    <>
      <PostContentComponent post={post} />
      <WriteCommentComponent />
      {comments &&
        comments.map((comment, idx) => (
          <CommentItemComponent
            key={comment._id}
            idx={idx}
            comments={comments}
            setComments={setComments}
          />
        ))}
    </>
  );
}
