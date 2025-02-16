"use client";

import { Label } from "@/components/ui/label";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { useState } from "react";

type Option = "ALL" | "FOLLOWING";

export default function SearchFilter() {
  const [option, setOption] = useState<Option>("ALL");

  const handleOption = (o: Option) => () => {
    if (o === option) return;
    setOption(o);
    // TODO : 서버에 데이터 요청
  };

  return (
    <div className="bg-slate-100 rounded-lg px-3 py-2 flex flex-col gap-y-2">
      <h1 className="text-lg font-bold">Search Filter</h1>

      <RadioGroup defaultValue="ALL">
        <ul className="flex flex-col gap-y-2">
          <li className="flex gap-x-4" onClick={handleOption("ALL")}>
            <RadioGroupItem value={"ALL"} />
            <Label>All</Label>
          </li>
          <li className="flex gap-x-4" onClick={handleOption("FOLLOWING")}>
            <RadioGroupItem value={"FOLLOWING"} />
            <Label>Following</Label>
          </li>
        </ul>
      </RadioGroup>
    </div>
  );
}
