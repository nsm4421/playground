"use client";

import { EditPostData, WritePostData } from "@/util/model";
import { useParams, useRouter } from "next/navigation";
import { Dispatch, SetStateAction, useEffect, useState } from "react";
import ErrorComponent from "../../../../components/error-component";
import useAxios from "@/util/hook/use-axios";
import useInput from "@/util/hook/use-input";
import axios from "axios";
import ButtonAtom from "@/components/atom/button-atom";
import InputAtom from "@/components/atom/input-atom";
import TextareaAtom from "@/components/atom/textarea-atom";
import AlertAtom from "@/components/atom/alert-atom";
import { useSession } from "next-auth/react";

export default function EditFormComponent() {
  const { data: session } = useSession();
  const params = useParams();
  const router = useRouter();
  const {
    value: title,
    setValue: setTitle,
    onChange: onTitleChange,
  } = useInput("", (value: string) => value.length <= 100);
  const {
    value: content,
    setValue: setContent,
    onChange: onContentChange,
  } = useInput("", (value: string) => value.length <= 5000);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const init = async () => {
    setIsLoading(true);
    const { postId } = params;
    if (!postId) return;
    const data = await axios
      .get(`/api/post?postId=${postId}`)
      .then((res) => res.data.data)
      .catch(console.error)
      .finally(() => setIsLoading(false));
    if (data.userId !== session?.user.id) {
      router.back();
      return;
    }
    setTitle(data.title);
    setContent(data.content);
  };

  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const handleGoBack = () => router.back();

  const handleSubmit = async () => {
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
      .put("/api/post", { postId:params.postId, title: title.trim(), content: content.trim() })
      .then(() => {
        alert("success");
        router.push("/post");
      })
      .catch(console.error)
      .finally(() => setIsLoading(false));
  };

  useEffect(() => {
    init();
  }, []);

  return (
    <>
      <div className="px-2 py-2 mt-3 flex justify-between">
        <h3 className="mb-4 text-xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-xl dark:text-white">
          Edit Post
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
        <p className="flex float-right text-gray-500 text-sm">
          {title.length}/100
        </p>
      </div>
      <div className="px-2 py-2">
        <TextareaAtom
          rows={20}
          label={"Content"}
          value={content}
          onChange={onContentChange}
        />
        <p className="flex float-right text-gray-500 text-sm">
          {content.length}/5000
        </p>
      </div>
      <AlertAtom errorMessage={errorMessage} />
    </>
  );
}
