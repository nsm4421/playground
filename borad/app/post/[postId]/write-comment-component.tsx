"use client";

import ButtonAtom from "@/components/atom/button-atom";
import InputAtom from "@/components/atom/input-atom";
import useInput from "@/util/hook/use-input";
import axios from "axios";
import { useParams } from "next/navigation";
import { useState } from "react";

export default function WriteCommentComponent(prpos:{refetch:Function}) {
  const params = useParams();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const {
    value: content,
    onChange: onContentChange,
    clear: clearContent,
  } = useInput("", (value: string) => value.length < 300);
  const handleSubmit = async () => {
    const postId = await params?.postId;
    if (!postId) return;
    setIsLoading(true);
    await axios
      .post("/api/post/comment", { content, postId })
      .then((_) => {
        clearContent()
        prpos.refetch()
      })
      .catch(console.error)
      .finally(() => setIsLoading(false));
  };

  return (
    <div className="flex justify-center shadow-sm">
      <div className="max-w-5xl w-full p-2">
        <span className="p-2 text-sm text-gray-600 dark:text-gray-300">
          Comment
        </span>
        <div className="p-2 flex justify-between">
          <div className="max-w-3xl w-full mr-2">
            <InputAtom value={content} onChange={onContentChange} />
          </div>
          <ButtonAtom onClick={handleSubmit} disabled={isLoading} label="Submit" />
        </div>
      </div>
    </div>
  );
}
