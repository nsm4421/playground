"use client";

import { usePathname } from "next/navigation";
import FollowRecommendSection from "./follow-recommend";
import TrendSection from "./trend";
import { RoutePaths } from "@/constant/route";
import SearchFilter from "./search-filter";

export default function RightSideBar() {
  const pathname = usePathname();

  return (
    <section className="h-full justify-start flex-col">
      <div className="flex-grow w-[300px]">
        <div className="max-h-[40vh] overflow-y-hidden mb-2">
          {/* 검색 페이지의 경우, 오른쪽 사이드바에 현재 트렌트 화면을 보여주지 않음 */}
          {pathname === RoutePaths.search ? (
            <SearchFilter />
          ) : (
            <TrendSection
              trends={Array.from({ length: 3 }, (_, i) => {
                return {
                  id: `${i}`,
                  title: "test3",
                  postNum: 3000,
                };
              })}
            />
          )}
        </div>
        <div className="max-h-[40vh] overflow-y-hidden">
          <FollowRecommendSection
            recommends={Array.from({ length: 3 }, (_, i) => {
              return {
                id: `${i}`,
                username: "test3",
                imageUrl: "test",
              };
            })}
          />
        </div>
      </div>
    </section>
  );
}
