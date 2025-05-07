import { Law, History } from "@/types/law";
import { create } from "zustand";

interface LawState {
  laws: Law[];
  setLaws: (lawId: Law[] | undefined) => void;
  history?: History;
  setHistory: (history: History | undefined) => void;
}

export const useLawState = create<LawState>((set) => ({
  laws: [],
  setLaws: (laws) => set((state) => ({ ...state, laws })),
  history: undefined,
  setHistory: (history: History | undefined) =>
    set((state) => ({ ...state, history })),
}));
