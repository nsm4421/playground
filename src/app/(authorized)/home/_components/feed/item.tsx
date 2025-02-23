import { Feed } from "@/lib/types/feed";
import dayjs from "dayjs";
import relativeTime from "dayjs/plugin/relativeTime";
import Image from "next/image";
import FeedIcons from "./icon";

dayjs.extend(relativeTime);

export default function FeedItem(feed: Feed) {
  return (
    <article className="rounded-lg">
      <div className="flex justify-start">
        <span className="text-md font-bold">{feed.user.username}</span>
        <span>{dayjs(feed.createdAt).fromNow()}</span>
      </div>
      <ul>
        {feed.images.map((img, idx) => (
          <li key={idx}>
            <Image
              src={"/images/test1.png"}
              width={500}
              height={500}
              alt={`feed${feed.id}_${idx}th`}
            />
          </li>
        ))}
      </ul>
      <span>{feed.content}</span>
      <FeedIcons {...feed} />
    </article>
  );
}
