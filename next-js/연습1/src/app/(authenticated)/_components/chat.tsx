"use client";

import {
  ResizableHandle,
  ResizablePanel,
  ResizablePanelGroup,
} from "@/lib/ui/resizable";

interface Props {
  cookieKey: string;
  defaultLayout: number[];
}

export default function ChatPannel({ cookieKey, defaultLayout }: Props) {
  const onLayout = (sizes: number[]) => {
    document.cookie = `${cookieKey}=${JSON.stringify(sizes)}`;
  };

  return (
    <ResizablePanelGroup
      direction={"horizontal"}
      className="h-full items-stretch bg-background rounded-lg"
      onLayout={onLayout}
    >
      <ResizablePanel
        defaultSize={defaultLayout[0]}
        minSize={8}
        maxSize={30}
      ></ResizablePanel>
      <ResizableHandle withHandle />
      <ResizablePanel
        defaultSize={defaultLayout[1]}
        minSize={30}
      ></ResizablePanel>
    </ResizablePanelGroup>
  );
}
