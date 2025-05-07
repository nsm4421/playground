import { cookies } from "next/headers";
import PreferenceTab from "./_components/preference";
import ChatPannel from "./_components/chat";

const cookieKey = "react-resizable-pannels:layout";

export default async function HomePage() {
  const value = (await cookies())?.get(cookieKey)?.value;
  const defaultLayout: number[] | undefined = value
    ? JSON.parse(value)
    : undefined;

  return (
    <main className="flex h-screen flex-col items-center justify-center p-4 md:px-24 py-32 gap-3">
      <PreferenceTab />
      <div className="z-10 border rounded-lg max-w-5xl w-full min-h-[85vh] text-sm lg:flex">
        <ChatPannel
          cookieKey={cookieKey}
          defaultLayout={defaultLayout ?? [320, 480]}
        />
      </div>
    </main>
  );
}
