"use client";

import AddAccountIcon from "@/components/icon/add-account";
import { Button } from "@/components/ui/button";

interface Item {
  id: string;
  imageUrl: string;
  username: string;
}

function FollowItem({ imageUrl, username }: Item) {
  const handleClick = () => {};

  return (
    <div className="flex items-center justify-between">
      <div className="flex gap-x-2 items-center">
        <span>Image</span>
        <label>{username}</label>
      </div>
      <Button size="icon" onClick={handleClick} className="group">
        <AddAccountIcon clsName="text-white group-hover:text-sky-400" />
      </Button>
    </div>
  );
}

interface Props {
  recommends: Item[];
}

export default function FollowRecommendSection({ recommends }: Props) {
  return (
    <div className="bg-slate-100 rounded-lg px-3 py-2 max-h-fit">
      <h1 className="text-lg font-bold">Follow Recommendation</h1>
      <ul className="flex flex-col gap-y-2 my-2">
        {recommends.map((item, idx) => (
          <li key={item.id}>
            <FollowItem
              id={`${idx}`}
              imageUrl={item.imageUrl}
              username={item.username}
            />
          </li>
        ))}
      </ul>
    </div>
  );
}
