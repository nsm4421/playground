"use client"

import { useParams } from "next/navigation";
import { ChangeEvent, useState } from "react";

export default function WriteCommentComponent() {
  const params = useParams();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [content, setContent] = useState<string>("");
  const handleComment = (e: ChangeEvent<HTMLInputElement>) => {
    setContent(e.target.value);
  };
  const handleSubmit = async () => {
    const postId = await params?._id;
    setIsLoading(true);
    await fetch("/api/post/comment", {
      method: "POST",
      body: JSON.stringify({ content,  postId}),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.success){
          setContent("");
          return;
        }
        alert(data.message)
      })
      .catch(console.error)
      .finally(() => setIsLoading(false));
  };

  return (
    <>
      <input value={content} onChange={handleComment} />
      <button disabled={isLoading} onClick={handleSubmit}>
        Submit
      </button>
    </>
  );
}
