"use client";

import { Address } from "@/lib/contant/map";
import mapboxgl, { LngLat, LngLatLike } from "mapbox-gl";
import { useEffect } from "react";

interface Props {
  from: Address;
  to: Address;
}

mapboxgl.accessToken = process.env.NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN!;

export default function RouteMap(props: Props) {
  const from = {
    lng: props.from.properties.coordinates.longitude,
    lat: props.from.properties.coordinates.latitude,
  };

  const to = {
    lng: props.to.properties.coordinates.longitude,
    lat: props.to.properties.coordinates.latitude,
  };

  const center = {
    lng: (from.lng + to.lng) / 2,
    lat: (from.lat + to.lat) / 2,
  };

  useEffect(() => {
    const map = new mapboxgl.Map({
      container: "map",
      center,
      zoom: 10,
    });

    handleAddMarker({ map, coord: from });
    handleAddMarker({ map, coord: to });
  }, []);

  const handleAddMarker = ({
    map,
    coord,
  }: {
    map: mapboxgl.Map;
    coord: LngLatLike;
  }) => {
    // const marker = new mapboxgl.Marker()
    //   .setDraggable(false)
    //   .setLngLat(coord)
    //   .addTo(map);
  };

  return (
    <section className="100vh">
      <div id="map"></div>
    </section>
  );
}
