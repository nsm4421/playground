"use client";

import { Address, Countries, Country, CountryCode } from "@/lib/contant/map";
import SelectAddressForm from "./select-address-form";
import { useState } from "react";
import { Button } from "@nextui-org/react";
import SelectCountryForm from "./select-country-form";

export default function AddPlanForm() {
  const [country, setCountry] = useState<Country | null>(null);
  const [fromAddress, setFromAddress] = useState<Address | null>(null);
  const [toAddress, setToAddress] = useState<Address | null>(null);

  const handleSearch = () => {
    // TODO : 검색결과를 지도에 표시하기
  }

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

      {country && fromAddress && toAddress && (
        <section>
          <Button onClick={handleSearch}>Handle Search</Button>
        </section>
      )}
    </div>
  );
}
