"use client";

import { Feed } from "@/lib/types/feed";
import FeedItem from "./item";
import {
  DehydratedState,
  HydrationBoundary,
  useQuery,
} from "@tanstack/react-query";
import { getFeedRecommends } from "@/lib/action/fetch-feeds";
import { ApiRoutes } from "@/lib/constant/route";

interface Props {
  dehydratedState: DehydratedState;
}

export default function FeedList({ dehydratedState }: Props) {
  const { data, error } = useQuery<Feed[]>({
    queryKey: ApiRoutes.fetchFeedRecommends.queryKeys ?? ["feed", "recommends"],
    queryFn: getFeedRecommends,
  });

  if (error) {
    console.error(error);
  }

  return (
    <HydrationBoundary state={dehydratedState}>
      <ul className="flex flex-col gap-y-3">
        {data?.map((item) => (
          <li key={item.id}>
            <FeedItem {...item} />
          </li>
        ))}
      </ul>
    </HydrationBoundary>
  );
}
