"use client";

import { CommentData } from "@/util/model";
import { useSession } from "next-auth/react";
import {
  ChangeEvent,
  Dispatch,
  SetStateAction,
  useEffect,
  useState,
} from "react";

export default function CommentItemComponent(props: {
  idx: number;
  comments: CommentData[];
  setComments: Dispatch<SetStateAction<CommentData[]>>;
}) {
  const { data: session } = useSession();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [isAuthor, setIsAuthor] = useState<boolean>(false);
  const [content, setContent] = useState<string>(
    props.comments[props.idx].content
  );
  const handleUpdateComment = async () => {
    setIsLoading(true);
    await fetch("/api/post/comment", {
      method: "PUT",
      body: JSON.stringify({
        commentId: props.comments[props.idx]._id,
        content: content,
      }),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.success) {
          const newComments = [...props.comments];
          newComments[props.idx].content = content;
          props.setComments(newComments);
          return;
        }
        alert(data.message);
      })
      .catch(console.error)
      .finally(() => setIsLoading(false));
  };
  const handleDeleteComment = async () => {
    setIsLoading(true);
    await fetch("/api/post/comment/delete", {
      method: "POST",
      body: JSON.stringify({ commentId: props.comments[props.idx]._id }),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.success) {
          const newComments = [...props.comments];
          newComments.splice(props.idx, 1);
          props.setComments(newComments);
          return;
        }
        alert(data.message);
      })
      .catch(console.error)
      .finally(() => setIsLoading(false));
  };
  const handleContent = (e: ChangeEvent<HTMLInputElement>) =>
    setContent(e.target.value);

  useEffect(() => {
    setIsAuthor(session?.user.id === props.comments[props.idx].userId);
  }, []);

  return (
    <div>
      <div>
        {isAuthor ? (
          <input value={content} onChange={handleContent} />
        ) : (
          <p>{content}</p>
        )}
      </div>
      <div>
        <span>{`Written by ${props.comments[props.idx].nickname}`}</span>
        <br />
        <span>{`Written at ${props.comments[props.idx].createdAt}`}</span>
        <br />
        <span>{`Updated at ${props.comments[props.idx].updatedAt}`}</span>
      </div>

      {/* post can be modfied or deleted by only author */}
      {isAuthor && (
        <div>
          <button onClick={handleUpdateComment}>Update</button>
          <button onClick={handleDeleteComment}>Delete</button>
        </div>
      )}
      <hr />
    </div>
  );
}
