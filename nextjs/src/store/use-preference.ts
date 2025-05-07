import { create } from "zustand";

type Preference = {
  isMute: boolean;
  setIsMute: (isMute: boolean) => void;
};

export const usePreferences = create<Preference>((set) => ({
  isMute: true,
  setIsMute: (isMute: boolean) => set({ isMute }),
}));
