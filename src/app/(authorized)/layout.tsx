import { ReactNode } from "react";
import HomeNav from "./_components/left-side-bar/home-nav";
import LogoutButton from "./_components/left-side-bar/logout-button";
import TrendSection from "./_components/right-side-bar/trend";
import FollowRecommendSection from "./_components/right-side-bar/follow-recommend";
import Logo from "./_components/logo";

interface Props {
  children: ReactNode;
}

export default function HomeLayout({ children }: Props) {
  return (
    <div className="w-full h-screen grid grid-cols-[350px_minmax(500px,_1fr)_350px] gap-2 py-2 overflow-y-hidden">
      <LeftSideBar />
      <main className="bg-slate-100 p-2 rounded-lg">{children}</main>
      <RightSideBar />
    </div>
  );
}

function LeftSideBar() {
  return (
    <section className="h-full flex items-end flex-col gap-y-2">
      <div className="flex w-[300px]">
        <Logo />
      </div>
      <div className="w-[300px]">
        <HomeNav />
      </div>
      <div className="bg-slate-100 rounded-lg px-3 py-2 w-[300px]">
        <LogoutButton label="Logout" />
      </div>
    </section>
  );
}

function RightSideBar() {
  return (
    <section className="h-full justify-start flex-col">
      <div className="flex-grow w-[300px]">
        <div className="max-h-[40vh] overflow-y-hidden mb-2">
          <TrendSection
            trends={Array.from({ length: 3 }, (_, i) => {
              return {
                id: `${i}`,
                title: "test3",
                postNum: 3000,
              };
            })}
          />
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
