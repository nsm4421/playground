"use client";

import Map from "react-map-gl";

interface Props {
  initialViewState: {
    longitude: number;
    latitude: number;
    zoom?: number;
  };
  style?: {
    width?: number;
    height?: number;
  };
}

export default function MapBoxMap(props: Props) {
  return (
    <section>
      <Map
        mapboxAccessToken={process.env.NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN}
        initialViewState={{ ...props.initialViewState }}
        style={{ ...props.style }}
        mapStyle="mapbox://styles/mapbox/streets-v9"
      />
    </section>
  );
}
