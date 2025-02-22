"use client";

import HomeIcon from "@/components/icon/home-icon";
import MessageIcon from "@/components/icon/message-icon";
import ProfileIcon from "@/components/icon/profile-icon";
import SearchIcon from "@/components/icon/search-icon";
import { RoutePaths } from "@/constant/route";
import Link from "next/link";
import { useSelectedLayoutSegment } from "next/navigation";
import { ReactNode } from "react";

type navItem = {
  label: string;
  seg: string;
  route: string;
  icon: ReactNode;
  activeIcon: ReactNode;
};

const navItems: navItem[] = [
  {
    label: "Home",
    seg: "home",
    route: RoutePaths.home,
    icon: <HomeIcon type="OUTLINED" />,
    activeIcon: <HomeIcon type="FILLED" fill />,
  },
  {
    label: "Search",
    seg: "search",
    route: RoutePaths.search,
    icon: <SearchIcon type="OUTLINED" />,
    activeIcon: <SearchIcon type="SOLID" fill />,
  },
  {
    label: "Messages",
    seg: "messages",
    route: RoutePaths.messages,
    icon: <MessageIcon />,
    activeIcon: <MessageIcon type="SOLID" fill />,
  },
  {
    label: "Profile",
    seg: "profile",
    route: RoutePaths.profile,
    icon: <ProfileIcon />,
    activeIcon: <ProfileIcon type="SOLID" fill />,
  },
];

export default function HomeNav() {
  const segment = useSelectedLayoutSegment();

  return (
    <ul className="flex flex-col gap-y-2 bg-slate-100 rounded-lg px-3 py-2">
      {navItems.map((i) => {
        return (
          <li key={i.seg}>
            <Link
              href={i.route}
              className="flex justify-start gap-x-2 cursor-pointer items-center"
            >
              <i>{i.seg === segment ? i.activeIcon : i.icon}</i>
              <span
                className={
                  i.seg === segment ? "text-sky-600 font-semibold" : ""
                }
              >
                {i.label}
              </span>
            </Link>
          </li>
        );
      })}
    </ul>
  );
}
