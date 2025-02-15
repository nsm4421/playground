import HomeHeader from "./_components/header";
import HomeTab from "./_components/header";

export default function HomePage() {
  return (
    <div className="h-full relative">
      <div className="h-full overflow-y-auto scrollbar-hide">
        <div className="w-full absolute backdrop-blur-xl flex flex-col gap-y-2 h-[80px]">
          <HomeHeader />
        </div>
        <div className="h-full pt-[80px]">
          <div className="h-96 bg-slate-200 my-2">test</div>
          <div className="h-96 bg-slate-200 my-2">test</div>
          <div className="h-96 bg-slate-200 my-2">test</div>
          <div className="h-96 bg-slate-200 my-2">test</div>
          <div className="h-96 bg-slate-200 my-2">test</div>
          <div className="h-96 bg-slate-200 my-2">test</div>
          <div className="h-1/2 bg-slate-200 my-2">test</div>
          <div className="h-1/2 bg-slate-200 my-2">test</div>
        </div>
      </div>
    </div>
  );
}
