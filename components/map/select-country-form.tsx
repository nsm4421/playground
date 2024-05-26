import { Countries, Country } from "@/lib/contant/map";
import { faRefresh } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Dispatch, SetStateAction } from "react";
import CountryFlag from "react-country-flag";

interface Props {
  country: Country | null;
  setCountry: Dispatch<SetStateAction<Country | null>>;
}

export default function SelectCountryForm(props: Props) {
  const handleSelct = (country: Country) => () => props.setCountry(country);
  const handleCancel = () => props.setCountry(null);

  return (
    <ul className="h-40 overflow-y-auto bg-slate-200 rounded-lg">
      {Countries.map((country, index) => (
        <li key={index}>
          <button
            onClick={handleSelct(country)}
            className="flex gap-x-2 items-center justify-start my-2 hover:bg-orange-500 w-full rounded-lg p-2"
          >
            <CountryFlag countryCode={country.countryCode} svg />
            <span className="font-semibold text-lg">{country.label}</span>
            <span className="text-sm text-slate-500">({country.ko})</span>
          </button>
        </li>
      ))}
    </ul>
  );
}
