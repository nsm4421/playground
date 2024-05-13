"use client";

import { Input } from "@nextui-org/react";
import axios from "axios";
import { useState } from "react";
import {
  faSearch,
  faRefresh,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { NextEndPoint } from "@/lib/contant/end-point";
import { CountryCode } from "@/lib/contant/map";
import { toast } from "react-toastify";

interface Props {
  label: string;
  placeholder?: string;
  country: CountryCode;
}

export default function SelectAddressForm(props: Props) {
  const maxLength: number = 30;
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [userInput, setAddress] = useState<string>("");
  const [selected, setSelected] = useState<string | null>(null);
  const [candidates, setCandidates] = useState<string[]>([]);

  const handleAddress = (text: string) => setAddress(text);

  const handleSearch = async () => {
    const q = userInput.trim();
    if (!q || isLoading) {
      return;
    }
    setIsLoading(true);
    await axios
      .get(NextEndPoint.searchAddress, {
        params: {
          q,
          country: props.country,
        },
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((res) => {
        const places = res.data.payload.map(
          (item: { place_formatted: string }) => item.place_formatted
        );
        setCandidates(places);
        if (places.length === 0) {
          toast.warn("Nothing Searched");
        }
      })
      .catch(console.error);

    setIsLoading(false);
  };

  const handleSelect = (address: string) => () => {
    setSelected(address);
    setCandidates([]);
  };

  const handleUnSelect = () => {
    setSelected(null);
  };

  return (
    <div>
      {selected == null ? (
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
        <Input
          maxLength={maxLength}
          value={selected}
          isReadOnly
          {...props}
          endContent={
            <i className="h-full items-center flex cursor-pointer hover:text-orange-600">
              <button onClick={handleUnSelect}>
                <FontAwesomeIcon icon={faRefresh} />
              </button>
            </i>
          }
        />
      )}

      {/* 검색결과 */}
      <ul className="absolute bg-slate-400 w-full">
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
                {address}
              </button>
            </li>
          ))}
      </ul>
    </div>
  );
}
