"use client";

import { useState } from "react";

import { Textarea } from "@/components/ui/textarea";
import CreateFeedModalButton from "./modal";
import TabPannel from "./tab";

export default function HomeHeader() {
  const MAX_LENGTH = 1000;
  const [tab, setTab] = useState<"RECOMMEND" | "FOLLOW">("RECOMMEND");
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [content, setContent] = useState<string>("");

  // TODO : 제출하기 기능 구현하기
  const handleSubmit = () => {};

  return (
    <div>
      <div className="flex justify-between">
        <h1 className="text-lg font-extrabold mb-2">Home</h1>
        <div>
          <CreateFeedModalButton isOpen={isOpen} setIsOpen={setIsOpen} />
        </div>
      </div>
      <div className="mx-2">
        <TabPannel tab={tab} setTab={setTab} />
      </div>
    </div>
  );
}
