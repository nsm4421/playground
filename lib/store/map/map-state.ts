import { create } from "zustand";

interface MapState {
  location: GeolocationPosition | null;
  setLocation: (location: GeolocationPosition) => void;
}

const useMapState = create<MapState>()((set) => ({
  location: null,
  setLocation: (location: GeolocationPosition) => set(() => ({ location })),
}));

export default useMapState;
