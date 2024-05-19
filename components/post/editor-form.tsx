"use client";

import { NextEndPoint } from "@/lib/contant/end-point";
import { faPencil, faUpload } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Input, Textarea } from "@nextui-org/react";
import axios from "axios";
import { SetStateAction, useState } from "react";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";
import HashatagForm from "./hashtag-form";
import CustomInput from "../form/custom-input";
import CustomTextarea from "../form/custom-textarea";

export default function Write() {
  const MAX_TITLE_LENGTH = 30;
  const MAX_CONTENT_LENGTH = 1000;

  const [title, setTitle] = useState<string>("");
  const [content, setContent] = useState<string>("");
  const [hashtags, setHashtags] = useState<string[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const router = useRouter();

  const handleUpload = async () => {
    // validate
    if (isLoading) {
      return;
    } else if (title.trim() === "") {
      toast.warn("Title is empty...");
      return;
    } else if (content.trim() === "") {
      toast.warn("Content is empty...");
      return;
    }
    setIsLoading(true);
    try {
      await axios
        .post(NextEndPoint.createPost, {
          title,
          content,
          hashtags,
        })
        .then(() => {
          toast.success("Success!");
          router.push("/post");
        })
        .catch((error) => {
          toast.error("Request Fail!");
          console.error(error);
        });
    } catch (error) {
      toast.error("Unknown Error!");
      console.error(error);
    }
    setIsLoading(false);
  };

  return (
    <main className="bg-slate-100 dark:bg-slate-700 rounded-lg mt-20">
      {/* 헤더 */}
      <section className="p-2 flex justify-between">
        <div className="flex items-center">
          <i className="mx-1">
            <FontAwesomeIcon icon={faPencil} />
          </i>

          <h1 className="text-xl font-bold "> Write Post</h1>
        </div>

        <div
          className={`flex gap-2 text-white bg-green-800 hover:bg-green-600 rounded-lg p-2 ${
            isLoading ? "cursor-wait" : "cursor-pointer "
          }`}
          onClick={handleUpload}
        >
          <span>UPLOAD</span>
          <FontAwesomeIcon icon={faUpload} />
        </div>
      </section>

      {/* 제목 */}
      <section className="mt-5 p-2">
        <CustomInput
          value={title}
          setValue={setTitle}
          maxLength={MAX_TITLE_LENGTH}
          label="TITLE"
          placehoder="ENTER TITLE"
        />
      </section>

      {/* 본문 */}
      <section className="mt-5 p-2">
        <CustomTextarea
          value={content}
          setValue={setContent}
          maxLength={MAX_CONTENT_LENGTH}
          maxRows={20}
          label="CONTENT"
          placehoder="ENTER CONTENT"
        />
      </section>

      {/* 해시태그 */}
      <section className="mt-5 p-2">
        <HashatagForm
          hashtags={hashtags}
          setHashtags={setHashtags}
          isEdit={false}
        />
      </section>
    </main>
  );
}
