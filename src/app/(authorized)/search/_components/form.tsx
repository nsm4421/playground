"use client";

import RefreshIcon from "@/components/icon/refresh-icon";
import SearchIcon from "@/components/icon/search-icon";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { RoutePaths } from "@/lib/constant/route";
import { useRouter, useSearchParams } from "next/navigation";
import { useState } from "react";

interface Props {
  q?: string;
}

type Option = "HOT" | "NEW";

export default function SearchForm({ q }: Props) {
  const [tab, setTab] = useState<Option>("HOT");
  const router = useRouter();
  const searchParams = useSearchParams();

  const handleTab = (selected: string) => {
    switch (selected) {
      case "HOT":
        setTab(selected);
        // router.replace(`${RoutePaths.search}?q=${searchParams.get("q")}`);5\

        router.replace(`${RoutePaths.search}?q=test`);
        break;
      case "NEW":
        setTab(selected);
        // router.replace(
        //   `${RoutePaths.search}?q=${searchParams.toString()}&f=live`
        // );
        router.replace(`${RoutePaths.search}?q=test&f=live`);
        break;
      default:
        console.error(`selected tab is not in option(given by ${selected})`);
    }
  };

  return (
    <section className="flex flex-col gap-y-3">
      <div className="flex gap-x-2 items-center">
        <SearchIcon />

        {/* <Input value={q} readOnly className="shadow-lg" /> */}
        <Input value={"test"} readOnly className="shadow-lg" />
        <Button size={"icon"}>
          <RefreshIcon clsName="text-white" />
        </Button>
      </div>
      <div>
        <Tabs defaultValue="RECOMMEND" value={tab} onValueChange={handleTab}>
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="HOT">
              <label
                className={`${tab === "HOT" && "font-semibold text-sky-600"}`}
              >
                🔥 HOT
              </label>
            </TabsTrigger>
            <TabsTrigger value="NEW">
              <label
                className={`${tab === "NEW" && "font-semibold text-sky-600"}`}
              >
                NEW
              </label>
            </TabsTrigger>
          </TabsList>
        </Tabs>
      </div>
    </section>
  );
}
