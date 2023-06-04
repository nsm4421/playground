"use client";

import PostFormComponent from "@/components/post-form-component";
import { WritePostData } from "@/util/model";
import { useRouter } from "next/navigation";
import { Dispatch, SetStateAction, useState } from "react";

export default function WriteFormComponent() {
  const router = useRouter();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const handleSubmit = async (input:WritePostData) => {
    setIsLoading(true);
    await fetch("/api/post", {
      method: "POST",
      body: JSON.stringify(input),
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
    <PostFormComponent isLoading={isLoading} setIsLoading={setIsLoading} initCallback={()=>{}} submitCallback={handleSubmit}/>
    </>
  );
}
