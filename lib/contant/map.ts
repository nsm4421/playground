export type CountryCode =
  | "KR"
  | "US"
  | "JP"
  | "CN"
  | "TH"
  | "VN"
  | "SG"
  | "MY"
  | "GB"
  | "FR"
  | "DE"
  | "IT";

export type Address = {
  mapbox_id: string;
  full_address?: string;
  place_formatted : string;
};

export type Country = {
  ko: string;
  label: string;
  countryCode: CountryCode;
};

export const Countries: Country[] = [
  { ko: "한국", countryCode: "KR", label: "Korea, Republic of" },
  { ko: "미국", countryCode: "US", label: "United States of America" },
  { ko: "일본", countryCode: "JP", label: "Japan" },
  { ko: "중국", countryCode: "CN", label: "China" },
  { ko: "태국", countryCode: "TH", label: "Thailand" },
  { ko: "베트남", countryCode: "VN", label: "Vietnam" },
  { ko: "싱가포르", countryCode: "SG", label: "Singapore" },
  { ko: "말레이시아", countryCode: "MY", label: "Malaysia" },
  { ko: "영국", countryCode: "GB", label: "United Kingdom" },
  { ko: "프랑스", countryCode: "FR", label: "France" },
  { ko: "독일", countryCode: "DE", label: "Germany" },
  { ko: "이탈리아", countryCode: "IT", label: "Italy" },
];
