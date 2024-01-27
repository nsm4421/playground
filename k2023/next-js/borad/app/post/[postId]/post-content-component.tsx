"use client";

import IconButtonAtom from "@/components/atom/icon-button-atom";
import { PostData } from "@/util/model";
import { ArrowLeftIcon } from "@heroicons/react/24/solid";
import axios from "axios";
import { useParams, useRouter } from "next/navigation";
import { useEffect, useState } from "react";

export default function PostContentComponent() {
  const [post, setPost] = useState<PostData | null>(null);
  const router = useRouter();
  const params = useParams();
  const handleGoBack = () => router.back();
  const init = async () => {
    const postId = await params.postId;
    if (!postId) return;
    await axios
      .get(`/api/post?postId=${postId}`)
      .then((res) => res.data.data)
      .then((data) => setPost(data));
  };
  useEffect(() => {
    init();
    return;
  }, []);

  return (
    <div className="flex justify-center">
      {post && (
        <div className="max-w-5xl w-full m-2 p-2 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
          {/* TODO : Add Image */}
          {/* <img
            className="rounded-t-lg"
            src="/docs/images/blog/image-1.jpg"
            alt=""
          /> */}

          <div className="px-2">
            <div className="flex justify-between">
              <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
                {post.title}
              </h5>
              <div>
                <IconButtonAtom
                  label="Back"
                  onClick={handleGoBack}
                  disabled={false}
                  icon={<ArrowLeftIcon className="w-5 h-5" />}
                />
              </div>
            </div>

            <div className="mt-2 mb-5 px-2">
              <span className="flex justify-end text-sm text-gray-500 dark:text-gray-300">
                {post.createdAt}
              </span>
            </div>

            <p className="p-2 font-normal mb-2 text-gray-700 dark:text-white dark:bg-slate-700">
              {post.content}
            </p>
          </div>
        </div>
      )}
    </div>
  );
}
