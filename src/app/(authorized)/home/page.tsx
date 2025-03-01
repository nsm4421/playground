import { dehydrate, QueryClient } from "@tanstack/react-query";
import FeedList from "./_components/feed/list";
import HomeHeader from "./_components/header/header";
import { getFeedRecommends } from "@/lib/action/fetch-feeds";
import { ApiRoutes } from "@/lib/constant/route";

export default async function HomePage() {
  const queryClient = new QueryClient();
  await queryClient.prefetchQuery({
    queryKey: ApiRoutes.fetchFeedRecommends.queryKeys ?? ["feed", "recommends"],
    queryFn: getFeedRecommends,
    staleTime: 60 * 1000, // 1분동안은 캐싱된 데이터 가져오기
  });
  const dehydreatedState = dehydrate(queryClient);

  return (
    <div className="h-full relative">
      <div className="h-full overflow-y-auto scrollbar-hide">
        <div className="w-full absolute backdrop-blur-xl flex flex-col gap-y-2 h-[80px]">
          <HomeHeader />
        </div>
        <div className="h-1/2 pt-[80px]">
          <FeedList dehydratedState={dehydreatedState} />
        </div>
      </div>
    </div>
  );
}
