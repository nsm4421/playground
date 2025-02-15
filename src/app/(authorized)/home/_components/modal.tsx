"use client";

import { ChangeEvent, Dispatch, SetStateAction, useRef, useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";

interface Props {
  isOpen: boolean;
  setIsOpen: Dispatch<SetStateAction<boolean>>;
}

export default function CreateFeedModalButton({ isOpen, setIsOpen }: Props) {
  const MAX_LENGTH = 1000;
  const [content, setContent] = useState<string>("");
  const ref = useRef<HTMLInputElement>(null);

  const handleContent = (e: ChangeEvent<HTMLTextAreaElement>) => {
    setContent(e.target.value);
  };

  // TODO : 제출하기 기능 구현하기
  const handleSubmit = () => {};

  return (
    <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogTrigger asChild>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="currentColor"
          className="size-6 cursor-pointer ml-1 group"
        >
          <path
            className="group-hover:text-sky-600"
            d="M21.731 2.269a2.625 2.625 0 0 0-3.712 0l-1.157 1.157 3.712 3.712 1.157-1.157a2.625 2.625 0 0 0 0-3.712ZM19.513 8.199l-3.712-3.712-8.4 8.4a5.25 5.25 0 0 0-1.32 2.214l-.8 2.685a.75.75 0 0 0 .933.933l2.685-.8a5.25 5.25 0 0 0 2.214-1.32l8.4-8.4Z"
          />
          <path
            className="group-hover:text-sky-600"
            d="M5.25 5.25a3 3 0 0 0-3 3v10.5a3 3 0 0 0 3 3h10.5a3 3 0 0 0 3-3V13.5a.75.75 0 0 0-1.5 0v5.25a1.5 1.5 0 0 1-1.5 1.5H5.25a1.5 1.5 0 0 1-1.5-1.5V8.25a1.5 1.5 0 0 1 1.5-1.5h5.25a.75.75 0 0 0 0-1.5H5.25Z"
          />
        </svg>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>모달 제목</DialogTitle>
        </DialogHeader>

        <div className="w-full">
          {/* TODO : 피드 작성 UI 및 기능 구현하기 */}
          <form onSubmit={handleSubmit}>
            <Textarea
              maxLength={MAX_LENGTH}
              className="resize-none scrollbar-hide border-collapse border-none focus:bg-slate-200 shadow-md"
              placeholder="write feed"
              onChange={handleContent}
              value={content}
            />
            <div>
              <input type="file" ref={ref} className="hidden" />
            </div>
          </form>
        </div>
      </DialogContent>
    </Dialog>
  );
}
