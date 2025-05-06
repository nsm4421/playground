"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useLawState } from "@/store/law";
import { useRef, useTransition } from "react";
import { ApiResponseType as SearchLawResponse } from "./api/search-law/route";
import { toast } from "sonner";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { History } from "@/types/law";
import { Separator } from "@/components/ui/separator";

export default function SelectLaw() {
  const ref = useRef<HTMLInputElement>(null);
  const { laws, setLaws, setHistory } = useLawState();
  const [isPending, startTransition] = useTransition();

  const handleSearch = async () => {
    const query = ref.current?.value;
    if (!query) return;
    startTransition(async () => {
      try {
        const endPoint = `/api/search-law?query=${query}`;
        const res = await fetch(endPoint, {
          headers: {
            Accept: "application/json",
          },
        });
        const json: SearchLawResponse = await res.json();
        if (json.data) {
          setLaws(json.data);
          toast("Success");
        } else {
          toast("Error", {
            description: json.message,
          });
        }
      } catch (error) {
        console.error(error);
        toast("Error", {
          description: "서버 오류가 발생했습니다",
        });
      }
    });
  };

  const handleSelectHistory = (h: History) => () => {
    setHistory(h);
  };

  return (
    <main className="h-screen">
      <section className="mx-3 my-2">
        <h1 className="my-1 font-semibold">법령 검색하기</h1>
        <div className="flex gap-x-2">
          <Input
            ref={ref}
            disabled={isPending}
            type="text"
            placeholder="법령명을 입력해주세요"
          />
          <Button
            disabled={isPending}
            onClick={handleSearch}
            className="cursor-pointer"
          >
            Search
          </Button>
        </div>
      </section>

      <Separator className="my-2" />

      <section className="mx-3 my-2">
        {isPending ? (
          <h1 className="mx-auto my-auto">Loadings...</h1>
        ) : (
          <div>
            <div className="flex justify-between items-center">
              <h1 className="my-1 font-semibold">조회결과</h1>
            </div>

            <Accordion type="single" collapsible className="w-full">
              {laws.map((l) => {
                return (
                  <AccordionItem key={l.법령ID} value={l.법령ID}>
                    <AccordionTrigger>{l.법령명한글}</AccordionTrigger>
                    <AccordionContent>
                      <Table className="px-3 py-1">
                        <TableHeader>
                          <TableRow>
                            <TableHead>법령일련번호</TableHead>
                            <TableHead>시행일자</TableHead>
                            <TableHead>공포일자</TableHead>
                            <TableHead>버튼</TableHead>
                          </TableRow>
                        </TableHeader>
                        <TableBody>
                          {l.개정이력.map((h, idx) => {
                            return (
                              <TableRow key={idx}>
                                <TableCell>{h.법령일련번호}</TableCell>
                                <TableCell>{h.시행일자}</TableCell>
                                <TableCell>{h.공포일자}</TableCell>
                                <TableCell>
                                  <Button
                                    onClick={handleSelectHistory(h)}
                                    variant={"ghost"}
                                  >
                                    조회
                                  </Button>
                                </TableCell>
                              </TableRow>
                            );
                          })}
                        </TableBody>
                      </Table>
                    </AccordionContent>
                  </AccordionItem>
                );
              })}
            </Accordion>
          </div>
        )}
      </section>
    </main>
  );
}
