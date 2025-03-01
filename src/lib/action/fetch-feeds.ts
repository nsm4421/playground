"use server";

import { revalidatePath } from "next/cache";
import { ApiRoutes, RoutePaths } from "../constant/route";

export async function getFeedRecommends() {
  const res = await fetch(
    `${process.env.NEXT_PUBLIC_BASE_URL}${ApiRoutes.fetchFeedRecommends.path}`,
    {
      next: {
        tags: ApiRoutes.fetchFeedRecommends.queryKeys ?? ["feed", "recommends"],
      },
    }
  );
  if (!res.ok) {
    console.error(await res.body);
    throw new Error("fail to fetch feed recommends");
  }
  revalidatePath(RoutePaths.home);
  return await res.json();
}
