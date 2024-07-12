"use client";

import { NextEndPoint } from "@/lib/contant/end-point";
import { faPencil, faUpload } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import axios from "axios";
import { useMemo, useState } from "react";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";
import HashatagForm from "./hashtag-form";
import CustomTextarea from "../../common/custom-textarea";
import PickImageForm from "./pick-image-form";
import { v4 } from "uuid";
import UploadFileAction from "@/lib/supabase/action/upload-file";

export default function Write() {
  const MAX_CONTENT_LENGTH = 1000;
  const postId = useMemo(() => v4(), []);
  const [content, setContent] = useState<string>("");
  const [hashtags, setHashtags] = useState<string[]>([]);
  const [imageFiles, setImageFiles] = useState<File[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const router = useRouter();

  const handleUpload = async () => {
    // validate
    if (isLoading) {
      return;
    } else if (content.trim() === "") {
      toast.warn("Content is empty...");
      return;
    }
    setIsLoading(true);
    let images: string[] = [];

    // 아미지 업로드하기
    try {
      if (imageFiles) {
        const futures = imageFiles.map(
          async (file, index) =>
            await UploadFileAction({
              bucketName: "posts",
              filename: `public/${postId}_${index}.jpg`,
              file,
              upsert: false,
            })
        );
        images = await Promise.all(futures);
      }
    } catch (error) {
      toast.error("Image upload fails");
      console.error(error);
      return; // early stop
    } finally {
      setIsLoading(false);
    }

    // 피드 업로드
    try {
      await axios
        .post(NextEndPoint.createPost, {
          id: postId,
          content,
          hashtags,
          images,
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
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <main className="bg-slate-100 dark:bg-slate-700 rounded-lg mt-20 py-3">
      {/* 헤더 */}
      <section className="p-2 flex justify-between">
        <div className="flex items-center">
          <i className="mx-1">
            <FontAwesomeIcon icon={faPencil} />
          </i>

          <h1 className="text-xl font-bold "> Write Post</h1>
        </div>

        {/* 업로드 버튼 */}
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

      {/* 본문 */}
      <section className="mt-5 p-2 bg-slate-200 dark:bg-slate-800 rounded-lg mx-2">
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
      <section className="mt-5 p-2 bg-slate-200 dark:bg-slate-800 rounded-lg mx-2">
        <HashatagForm
          hashtags={hashtags}
          setHashtags={setHashtags}
          isEdit={true}
        />
      </section>

      {/* 이미지 업로드 */}
      <section className="mt-5 p-2 bg-slate-200 dark:bg-slate-800 rounded-lg mx-2">
        <PickImageForm
          imageFiles={imageFiles}
          setImageFiles={setImageFiles}
          maxNumber={3}
        />
      </section>
    </main>
  );
}
