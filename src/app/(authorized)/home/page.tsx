import FeedList from "./_components/feed/list";
import HomeHeader from "./_components/header/header";

export default function HomePage() {
  return (
    <div className="h-full relative">
      <div className="h-full overflow-y-auto scrollbar-hide">
        <div className="w-full absolute backdrop-blur-xl flex flex-col gap-y-2 h-[80px]">
          <HomeHeader />
        </div>
        <div className="h-1/2 pt-[80px]">
          <FeedList
            feeds={Array.from({ length: 100 }, (_, i) => ({
              id: `${i}`,
              user: {
                id: "1",
                username: "test1",
                image: "https://picsum.photos/200",
                createdAt: Date.now().toLocaleString(),
              },
              content: "test content",
              images: ["https://picsum.photos/200"],
              createdAt: Date.now().toLocaleString(),
            }))}
          />
        </div>
      </div>
    </div>
  );
}
