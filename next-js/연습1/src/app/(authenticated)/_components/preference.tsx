"use client";

import { Button } from "@/lib/ui/button";
import { mp3AssetPath } from "@/lib/utils/asset";
import { usePreferences } from "@/store/use-preference";
import { MoonIcon, SunIcon, Volume2Icon, VolumeOffIcon } from "lucide-react";
import { useTheme } from "next-themes";
import { useSound } from "use-sound";

export default function PreferenceTab() {
  const { setTheme } = useTheme();
  const { isMute, setIsMute } = usePreferences();
  const [playMouseClick] = useSound(mp3AssetPath.click, { volume: 0.5 });

  const handleSwitchLightMode = () => {
    if (!isMute) {
      playMouseClick();
    }
    setTheme("light");
  };
  const handleSwitchDarkMode = () => {
    if (!isMute) {
      playMouseClick();
    }
    setTheme("dark");
  };
  const handleIsMute = () => {
    if (!isMute) {
      playMouseClick();
    }
    setIsMute(!isMute);
  };

  return (
    <div className="flex flex-wrap gap-2 px-1 md:px-2">
      <Button size={"icon"} variant={"outline"} onClick={handleSwitchLightMode}>
        <SunIcon className="size-[1.2rem] text-muted-foreground" />
      </Button>

      <Button size={"icon"} variant={"outline"} onClick={handleSwitchDarkMode}>
        <MoonIcon className="size-[1.2rem] text-muted-foreground" />
      </Button>

      <Button size={"icon"} variant={"outline"} onClick={handleIsMute}>
        {isMute ? (
          <VolumeOffIcon className="size-[1.2rem] text-muted-foreground" />
        ) : (
          <Volume2Icon className="size-[1.2rem] text-muted-foreground" />
        )}
      </Button>
    </div>
  );
}
