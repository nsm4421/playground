"use client";

import { NextEndPoint } from "@/lib/contant/end-point";
import { faUpload } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Input } from "@nextui-org/react";
import axios from "axios";
import { ChangeEvent, useMemo, useState } from "react";
import "react-quill/dist/quill.snow.css";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";

export default function Write() {
  const formats = useMemo(
    () => [
      "header",
      "font",
      "size",
      "bold",
      "italic",
      "underline",
      "strike",
      "blockquote",
      "list",
      "bullet",
      "indent",
      "link",
      "image",
    ],
    []
  );

  const modules = useMemo(
    () => ({
      toolbar: [
        [{ header: "1" }, { header: "2" }, { font: [] }],
        [{ size: [] }],
        ["bold", "italic", "underline", "strike", "blockquote"],
        [
          { list: "ordered" },
          { list: "bullet" },
          { indent: "-1" },
          { indent: "+1" },
        ],
        ["link", "image"],
        ["clean"],
      ],
    }),
    []
  );

  const [title, setTitle] = useState<string>("");
  const [content, setContent] = useState<string>("");
  // TODO : 해시태그 업로드 기능
  const [hashtags, setHashtags] = useState<string[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const router = useRouter();
  // Referencd : https://m.blog.naver.com/choirj91/222044740530
  let ReactQuill =
    typeof window === "object" ? require("react-quill") : () => false;

  const handleTitle = (e: ChangeEvent<HTMLInputElement>) =>
    setTitle(e.target.value);

  const handleContent = (v: string) => {
    setContent(v);
  };

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
    <section className="bg-slate-100 dark:bg-slate-700 rounded-lg">
      <div className="p-2 justify-between flex items-center">
        <div className="w-full mr-3">
          <Input
            size="lg"
            label="TITLE"
            placeholder="Write Title"
            value={title}
            onChange={handleTitle}
          />
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
      </div>
      <div className="p-2">
        {ReactQuill && (
          <ReactQuill
            modules={modules}
            formats={formats}
            onChange={handleContent}
            value={content}
            placeholder="Write Article"
          />
        )}
      </div>
    </section>
  );
}
