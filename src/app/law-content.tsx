"use client";

import { useLawState } from "@/store/law";
import { useEffect, useState, useTransition } from "react";
import { History } from "@/types/law";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";

export default function LawContent() {
  const { history, setHistory } = useLawState();
  const [isPending, startTransition] = useTransition();
  const [htmlText, setHtmlText] = useState<string | undefined>(undefined);

  const init = async (h: History) => {
    startTransition(async () => {
      try {
        const endPoint = `http://www.law.go.kr/DRF/lawService.do?OC=nsm4421&target=eflaw&type=HTML&MST=${h.법령일련번호}&efYd=${h.시행일자}`;
        const res = await fetch(endPoint);
        if (!res.ok) {
          throw Error("에러가 발생했습니다");
        }
        setHtmlText(await res.text());
        toast("Success");
      } catch (error) {
        console.error(error);
        toast("Error", {
          description: "에러가 발생했습니다",
        });
      }
    });
  };

  const handleReset = () => {
    setHistory(undefined);
  };

  useEffect(() => {
    if (history) {
      init(history);
    }
    // return () => setHtmlText(undefined);
  }, []);

  return (
    <div>
      <div className="flex justify-between mx-5 py-2">
        <h1 className="text-xl">법령 조회</h1>
        <Button onClick={handleReset}>Reset</Button>
      </div>
      <main className="mx-5 py-2 flex">
        {isPending && <h1 className="mx-auto my-auto text-3xl">Loadings...</h1>}
        {!isPending && htmlText && (
          <iframe
            srcDoc={htmlText}
            style={{ width: "100%", height: "80vh", border: "none" }}
            sandbox="allow-scripts allow-same-origin"
          />
        )}
      </main>
    </div>
  );
}
