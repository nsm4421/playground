"use client";

import ClearIconButton from "@/components/button/clear-button";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { useRouter } from "next/navigation";
import { ChangeEvent, useRef, useState } from "react";

export default function ComposeFeedModalPage() {
  const MAX_LENGTH = 1000;
  const [content, setContent] = useState<string>("");
  const ref = useRef<HTMLInputElement>(null);
  const router = useRouter();

  const handleContent = (e: ChangeEvent<HTMLTextAreaElement>) => {
    setContent(e.target.value);
  };

  const handleClickPictureIcon = () => {
    ref?.current?.click();
  };
  const handleClose = () => {
    router.back();
  };

  // TODO : 제출하기 기능 구현하기
  const handleSubmit = () => {};

  return (
    <div className="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50">
      <div className="bg-white rounded-2xl shadow-xl max-w-md w-full p-6 relative">
        <header className="flex justify-between items-center mb-3">
          <h2 className="text-xl font-semibold text-gray-800 mb-3">
            Compose Feed
          </h2>
          <ClearIconButton onClick={handleClose} />
        </header>

        <div className="w-full flex flex-1 flex-col flex-end gap-y-3">
          {/* TODO : 피드 작성 UI 및 기능 구현하기 */}
          <form onSubmit={handleSubmit}>
            <Textarea
              maxLength={MAX_LENGTH}
              rows={8}
              className="resize-none scrollbar-hide border-collapse border-none focus:bg-slate-200 shadow-md"
              placeholder="write feed"
              onChange={handleContent}
              value={content}
            />
            <input type="file" ref={ref} className="hidden" />
          </form>

          <footer className="flex justify-between">
            <Button
              onClick={handleClickPictureIcon}
              variant="ghost"
              className="px-1"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="currentColor"
                className="size-6"
              >
                <path
                  fillRule="evenodd"
                  d="M1.5 6a2.25 2.25 0 0 1 2.25-2.25h16.5A2.25 2.25 0 0 1 22.5 6v12a2.25 2.25 0 0 1-2.25 2.25H3.75A2.25 2.25 0 0 1 1.5 18V6ZM3 16.06V18c0 .414.336.75.75.75h16.5A.75.75 0 0 0 21 18v-1.94l-2.69-2.689a1.5 1.5 0 0 0-2.12 0l-.88.879.97.97a.75.75 0 1 1-1.06 1.06l-5.16-5.159a1.5 1.5 0 0 0-2.12 0L3 16.061Zm10.125-7.81a1.125 1.125 0 1 1 2.25 0 1.125 1.125 0 0 1-2.25 0Z"
                  clipRule="evenodd"
                />
              </svg>
              <span>Select</span>
            </Button>
            <Button>Submit</Button>
          </footer>
        </div>
      </div>
    </div>
  );
}
