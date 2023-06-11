"use client";

import { EditPostData, WritePostData } from "@/util/model";
import { useParams, useRouter } from "next/navigation";
import { Dispatch, SetStateAction, useEffect, useState } from "react";
import ErrorComponent from "../../../../components/error-component";
import PostFormComponent from "@/components/post-form-component";

export default function EditFormComponent() {
  // check param is valid
  const params = useParams();
  if (!params?._id) {
    return <ErrorComponent />;
  }

  const router = useRouter();
  const [initData, setInitData] = useState<EditPostData>({
    postId: "",
    title: "",
    content: "",
  });
  const [isLoading, setIsLoading] = useState<boolean>(false);

  // get post by id
  const initCallback = async (
    setInput: Dispatch<SetStateAction<WritePostData>>
  ) => {
    setIsLoading(true);
    await fetch(`/api/post?_id=${params._id}`)
      .then((res) => res.json())
      .then((data) => {
        setInput(data.data);
      })
      .finally(() => setIsLoading(false));
  };

  // put request
  const handleSubmit = async (input: WritePostData) => {
    setIsLoading(true);
    await fetch("/api/post", {
      method: "PUT",
      body: JSON.stringify({ ...input, _id: params._id }),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.success) {
          alert("Success");
          router.push("/post");
        } else {
          alert(data.message);
        }
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  return (
    <>
      <PostFormComponent
        isLoading={isLoading}
        setIsLoading={setIsLoading}
        initCallback={initCallback}
        submitCallback={handleSubmit}
      />
    </>
  );
}
