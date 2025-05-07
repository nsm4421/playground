"use client";

import { Button } from "@/components/ui/button";
import { useLawState } from "@/store/law";
import { useEffect, useState, useTransition } from "react";
import { toast } from "sonner";

export default function CurrentLawPage() {
  const [isPending, startTransition] = useTransition();
  const [html, setHtml] = useState<string>("");
  const { history } = useLawState();

  const init = async () => {
    const baseUrl = "http://www.law.go.kr/DRF/lawService.do";
    const endPoint = `${baseUrl}?target=law&type=HTML&OC=nsm4421&ID=${history?.법령ID}`;
    startTransition(async () => {
      try {
        const res = await fetch(endPoint);
        if (res.ok) {
          toast("Success");
          setHtml(await res.text());
        } else {
          toast("Error", {
            description: res.statusText,
          });
        }
      } catch (error) {
        console.error(error);
        toast("Error");
      }
    });
  };

  useEffect(() => {
    if (history?.법령ID) {
      init();
    }
    return () => setHtml("");
  }, []);

  if (!history) {
    return (
      <div className="flex h-screen">
        <Button className="mx-auto my-auto">
          <a href="/select-law">선택된 법령이 없습니다.</a>
        </Button>
      </div>
    );
  }

  return (
    <div>
      {isPending ? (
        <h1>로딩중입니다</h1>
      ) : (
        <iframe
          srcDoc={html}
          style={{ width: "100%", height: "100vh", border: "none" }}
          sandbox="allow-scripts allow-same-origin"
        />
      )}
    </div>
  );
}
