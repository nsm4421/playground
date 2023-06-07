"use client";

import { PostData } from "@/util/model";
import { useRouter } from "next/navigation";

export default function PostContentComponent(props: { post: PostData | null }) {
  const router = useRouter();

  const handleGoBack = () => router.back();

  if (!props.post) {
    <>
      <h3>Loadings...</h3>
    </>;
  }

  return (
    <>
      <h3>Posting</h3>
      <p>{props?.post?.title}</p>
      <p>{props.post?.content}</p>
      <button onClick={handleGoBack}>Go Back</button>
    </>
  );
}
