import { Feed } from "@/lib/types/feed";
import FeedItem from "./item";

interface Props {
  feeds: Feed[];
}

export default function FeedList({ feeds }: Props) {
  return (
    <ul className="flex flex-col gap-y-3">
      {feeds.map((item) => (
        <li key={item.id}>
          <FeedItem {...item} />
        </li>
      ))}
    </ul>
  );
}
