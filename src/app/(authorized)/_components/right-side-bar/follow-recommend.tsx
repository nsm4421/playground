"use client";

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
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth="1.5"
          stroke="currentColor"
          className="size-6"
        >
          <path
            className="text-white group-hover:text-sky-400"
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M18 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0ZM3 19.235v-.11a6.375 6.375 0 0 1 12.75 0v.109A12.318 12.318 0 0 1 9.374 21c-2.331 0-4.512-.645-6.374-1.766Z"
          />
        </svg>
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
