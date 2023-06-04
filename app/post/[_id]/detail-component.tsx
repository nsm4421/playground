"use client";

import { PostData } from "@/util/model";
import { useParams, useRouter } from "next/navigation";
import { useEffect, useState } from "react";

export default function DetailComponent() {
  const params = useParams();
  const router = useRouter();
  const [post, setPost] = useState<PostData | null>(null);
  const _setPost = async () => {
    if (!params?._id) return null;
    await fetch(`/api/post?_id=${params._id}`)
      .then((res) => res.json())
      .then((data) => {
        console.log(data.message);
        if (data.success) {
          setPost(data.data);
        }
      });
  };
  const handleGoBack = () => router.back();

  useEffect(() => {
    _setPost();
    return;
  }, []);

  return (
    <>
      <h3>{post?.title}</h3>
      <p>{post?.content}</p>
      <button onClick={handleGoBack}>Go Back</button>
    </>
  );
}
