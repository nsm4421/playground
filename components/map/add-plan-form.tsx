"use client";

import { Address, Country } from "@/lib/contant/map";
import SelectAddressForm from "./select-address-form";
import { useState } from "react";
import SelectCountryForm from "./select-country-form";
import Map, { FullscreenControl, Layer, MapProvider } from "react-map-gl";
import Marker from "react-map-gl/dist/esm/components/marker";

export default function AddPlanForm() {
  const [country, setCountry] = useState<Country | null>(null);
  const [fromAddress, setFromAddress] = useState<Address | null>(null);
  const [toAddress, setToAddress] = useState<Address | null>(null);

  return (
    <div className="w-full rounded-lg px-5 py-2">
      <section
        aria-label="country"
        className="bg-slate-200 rounded-lg p-2 mb-2"
      >
        <label className="text-lg font-extrabold">Country</label>
        <SelectCountryForm country={country} setCountry={setCountry} />
      </section>

      {country?.countryCode && (
        <section
          aria-label="from-to-location"
          className="bg-slate-200 rounded-lg p-2"
        >
          <label className="text-lg font-extrabold">Location</label>
          <ul>
            <li className="m-2">
              <SelectAddressForm
                label={"From"}
                country={country?.countryCode}
                selected={fromAddress}
                setSelected={setFromAddress}
              />
            </li>
            <li className="m-2">
              <SelectAddressForm
                label={"To"}
                country={country?.countryCode}
                selected={toAddress}
                setSelected={setToAddress}
              />
            </li>
          </ul>
        </section>
      )}

      {/* 지도 */}
      {fromAddress && toAddress && (
        <MapProvider>
          <Map
            mapboxAccessToken={process.env.NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN}
            initialViewState={{
              longitude:
                (fromAddress.properties.coordinates.longitude +
                  toAddress.properties.coordinates.longitude) /
                2,
              latitude:
                (toAddress.properties.coordinates.latitude +
                  toAddress.properties.coordinates.latitude) /
                2,
              zoom: 10,
            }}
            attributionControl={false}
            mapStyle="mapbox://styles/mapbox/streets-v9"
            style={{ width: 600, height: 400, background: "red" }}
          >
            {/* <Marker
              longitude={fromAddress.properties.coordinates.longitude}
              latitude={fromAddress.properties.coordinates.latitude}
            /> */}
          </Map>
        </MapProvider>
      )}
    </div>
  );
}
