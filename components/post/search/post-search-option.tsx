"use client";

import React, { useState } from "react";
import { Accordion, AccordionItem, Input } from "@nextui-org/react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faFilter,
} from "@fortawesome/free-solid-svg-icons";

export default function PostSeachOption() {
  const [content, setContent] = useState<string>("");
  const [hashtag, setHashtag] = useState<string>("");

  return (
    <section className="bg-slate-200 rounded-lg border-dotted p-2 mx-2">
      <div className="mx-1 flex gap-x-2 items-center">
        <i>
          <FontAwesomeIcon icon={faFilter} />
        </i>
        <h1 className="text-2xl font-semibold">Search Option</h1>
      </div>
      <Accordion defaultExpandedKeys={["content"]} className="mx-3">
        <AccordionItem key="content" title="Content">
          <Input
            value={content}
            onValueChange={setContent}
            maxLength={20}
            placeholder="content"
          />
        </AccordionItem>
        <AccordionItem key="tag" title="Tag">
          <Input
            value={hashtag}
            onValueChange={setHashtag}
            maxLength={20}
            placeholder="content"
          />
        </AccordionItem>
      </Accordion>
    </section>
  );
}
