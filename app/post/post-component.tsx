"use client";

import { PostData } from "@/util/model";
import Link from "next/link";
import DeletePostButton from "./delete-post-button";
import { useSession } from "next-auth/react";

export default function PostComponent(props: {
  post: PostData;
  deletePost: Function;
}) {
  const session = useSession();

  if (!props.post)
    return (
      <>
        <h3>Post Not Found</h3>
      </>
    );

  return (
    <div>
      <Link href={`/post/${props.post._id}`}>
        <h3>{props.post.title}</h3>
      </Link>
      <p>{props.post.content}</p>

      {/* if login user and author are equal, then show edit, delete button */}
      {props.post.email === session.data?.user?.email && (
        <div>
          <Link href={`/post/edit/${props.post._id}`}>
            <button>Edit Post</button>
          </Link>
          <DeletePostButton
            _id={props.post._id}
            deletePost={props.deletePost}
          />
        </div>
      )}
      <hr />
    </div>
  );
}
