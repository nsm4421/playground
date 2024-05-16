import { Countries, Country } from "@/lib/contant/map";
import { faRefresh } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Dispatch, SetStateAction } from "react";
import CountryFlag from "react-country-flag";
import Select from "react-select";

interface Props {
  country: Country | null;
  setCountry: Dispatch<SetStateAction<Country | null>>;
}

export default function SelectCountryForm(props: Props) {
  const handleCancel = () => props.setCountry(null);

  return (
    <>
      {props.country ? (
        <div className="flex justify-between p-2">
          <div>
            <CountryFlag countryCode={props.country.countryCode} svg />
            <span className="ml-3 text-md">{props.country.label}</span>
            <span className="ml-3 text-slate-700 dark:text-slate-400 text-sm">
              {props.country.ko}
            </span>
          </div>
          <div
            className="cursor-pointer px-1 hover:bg-orange-500 rounded-full"
            onClick={handleCancel}
          >
            <FontAwesomeIcon icon={faRefresh} />
          </div>
        </div>
      ) : (
        <Select
          options={Countries}
          value={props.country}
          onChange={(e) => {
            props.setCountry(e);
          }}
          placeholder="Select country"
        />
      )}
    </>
  );
}
