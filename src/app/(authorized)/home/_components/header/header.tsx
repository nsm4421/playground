"use client";

import { useState } from "react";
import OpenComposeFeedModalButton from "./modal";
import TabPannel from "./tab";

export default function HomeHeader() {
  const [tab, setTab] = useState<"RECOMMEND" | "FOLLOW">("RECOMMEND");

  // TODO : 제출하기 기능 구현하기
  const handleSubmit = () => {};

  return (
    <div>
      <div className="flex justify-between">
        <h1 className="text-lg font-extrabold mb-2">Home</h1>
        <div>
          <OpenComposeFeedModalButton />
        </div>
      </div>
      <div className="mx-2">
        <TabPannel tab={tab} setTab={setTab} />
      </div>
    </div>
  );
}
