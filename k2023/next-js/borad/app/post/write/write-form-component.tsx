"use client";

import AlertAtom from "@/components/atom/alert-atom";
import ButtonAtom from "@/components/atom/button-atom";
import InputAtom from "@/components/atom/input-atom";
import TextareaAtom from "@/components/atom/textarea-atom";
import useInput from "@/util/hook/use-input";
import axios from "axios";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default function WriteFormComponent() {
  const router = useRouter();
  const { value: title, onChange: onTitleChange } = useInput(
    "",
    (value: string) => value.length <= 100
  );
  const { value: content, onChange: onContentChange } = useInput(
    "",
    (value: string) => value.length <= 5000
  );
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const handleGoBack = () => router.back();

  const handleSubmit = async () => {    
    console.log("Test")
    if (!title.trim()) {
      setErrorMessage("title is blank");
      return;
    }
    if (!content.trim()) {
      setErrorMessage("title is blank");
      return;
    }
    setIsLoading(true);
    await axios
      .post("/api/post", { title: title.trim(), content: content.trim() })
      .then(() => {
        alert("success");
        router.push("/post");
      })
      .catch((err) => {
        console.log(err);
      })
      .finally(() => setIsLoading(false));
  };

  return (
    <>
      <div className="px-2 py-2 mt-3 flex justify-between">
        <h3 className="mb-4 text-xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-xl dark:text-white">
          Write Post
        </h3>
        <div>
          <ButtonAtom
            onClick={handleGoBack}
            color="blue"
            disabled={false}
            label={"Back"}
          />
          <ButtonAtom
            onClick={handleSubmit}
            color="green"
            disabled={isLoading}
            label={"Submit"}
          />
        </div>
      </div>
      <div className="px-2 py-2 mt-3">
        <InputAtom label={"Title"} value={title} onChange={onTitleChange} />
        <p className="flex float-right text-gray-500 text-sm">{title.length}/100</p>
      </div>
      <div className="px-2 py-2">
        <TextareaAtom
        rows={20}
          label={"Content"}
          value={content}
          onChange={onContentChange}
        />
        <p className="flex float-right text-gray-500 text-sm">{content.length}/5000</p>
      </div>
      <AlertAtom errorMessage={errorMessage}/>
    </>
  );
}
