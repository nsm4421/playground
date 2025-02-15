"use client";

import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Dispatch, SetStateAction } from "react";

interface Props {
  tab: "RECOMMEND" | "FOLLOW";
  setTab: Dispatch<SetStateAction<"RECOMMEND" | "FOLLOW">>;
}

export default function TabPannel({ tab, setTab }: Props) {
  const handleTab = (selected: string) => {
    if (selected !== "RECOMMEND" && selected !== "FOLLOW") {
      console.error(`selected tab is not in option(given by ${selected})`);
    } else if (selected === tab) {
      return;
    } else {
      setTab(selected);
    }
  };

  return (
    <Tabs defaultValue="RECOMMEND" value={tab} onValueChange={handleTab}>
      <TabsList className="grid w-full grid-cols-2">
        <TabsTrigger value="RECOMMEND">
          <label
            className={`${tab === "RECOMMEND" && "font-semibold text-sky-600"}`}
          >
            RECOMMEND
          </label>
        </TabsTrigger>
        <TabsTrigger value="FOLLOW">
          <label
            className={`${tab === "FOLLOW" && "font-semibold text-sky-600"}`}
          >
            FOLLOW
          </label>
        </TabsTrigger>
      </TabsList>
    </Tabs>
  );
}
