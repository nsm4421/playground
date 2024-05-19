"use client";

import { Input } from "@nextui-org/react";
import axios from "axios";
import { faSearch, faRefresh } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { RemoteEndPoint } from "@/lib/contant/end-point";
import { Address, CountryCode } from "@/lib/contant/map";
import { toast } from "react-toastify";
import { Dispatch, SetStateAction, useState } from "react";

interface Props {
  label: string;
  placeholder?: string;
  country: CountryCode;
  selected: Address | null;
  setSelected: Dispatch<SetStateAction<Address | null>>;
  errorMessage?: string;
}

export default function SelectAddressForm(props: Props) {
  const maxLength: number = 30;
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [userInput, setAddress] = useState<string>("");
  const [candidates, setCandidates] = useState<Address[]>([]);

  const handleAddress = (text: string) => setAddress(text);

  const handleSearch = async () => {
    const q = userInput.trim();
    if (!q || isLoading) {
      return;
    }
    setIsLoading(true);
    // Refernce : https://docs.mapbox.com/api/search/geocoding/
    await axios
      .get(RemoteEndPoint.searchAddress, {
        params: {
          q,
          country: props.country,
          language: "en",
          session_token: process.env.NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN,
          access_token: process.env.NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN,
          limit: 3,
        },
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((res) => {
        const addresses: Address[] = res.data.features;
        setCandidates(addresses);
        if (addresses.length === 0) {
          toast.info("nothing searched");
        }
      })
      .catch((error) => {
        toast.error(props.errorMessage ?? "error occurs");
        console.error(error);
      });

    setIsLoading(false);
  };

  const handleSelect = (address: Address) => () => {
    props.setSelected(address);
    setCandidates([]);
  };

  const handleUnSelect = () => {
    props.setSelected(null);
  };

  return (
    <div>
      {props.selected == null ? (
        // 검색어 입력창
        <Input
          maxLength={maxLength}
          value={userInput}
          onValueChange={handleAddress}
          {...props}
          endContent={
            <i className="h-full items-center flex cursor-pointer hover:text-orange-600">
              <button onClick={handleSearch}>
                <FontAwesomeIcon icon={faSearch} />
              </button>
            </i>
          }
        />
      ) : (
        // 선택된 주소
        <div className="flex justify-between">
          <span>{props.selected.properties.full_address}</span>
          <i className="h-full items-center flex cursor-pointer hover:text-orange-600">
            <button onClick={handleUnSelect}>
              <FontAwesomeIcon icon={faRefresh} />
            </button>
          </i>
        </div>
      )}

      {/* 검색결과 */}
      <ul className="bg-slate-400 w-full">
        {candidates &&
          candidates.map((address, index) => (
            <li key={index} className="p-2 hover:bg-sky-200 hover:font-bold">
              <button
                onClick={handleSelect(address)}
                disabled={isLoading}
                className={`w-full hover:${
                  isLoading ? "cursor-wait" : "cursor-pointer"
                }`}
              >
                {address.properties.place_formatted}
              </button>
            </li>
          ))}
      </ul>
    </div>
  );
}
