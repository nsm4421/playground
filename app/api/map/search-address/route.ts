import { RemoteEndPoint } from "@/lib/contant/end-point";
import { CountryCode } from "@/lib/contant/map";
import axios from "axios";
import { NextResponse } from "next/server";

/// 주소 검색하기 - https://docs.mapbox.com/api/search/search-box/
export async function GET(request: Request) {
  // parsing request
  const { searchParams } = new URL(request.url);
  const q = searchParams.get("q") as string | null;
  const country = searchParams.get("country") as CountryCode | null;

  // validation
  if (!q || !country) {
    console.error(`파라메터가 잘못들어옴 \n q : ${q} / country : ${country}`);
    return NextResponse.json({}, { status: 400, statusText: "BAD REQUEST" });
  }

  // MapBox API
  const res = await axios.get(RemoteEndPoint.searchAddress, {
    params: {
      q,
      language: "en",
      access_token: process.env.NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN,
      session_token: process.env.NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN,
      country: country,
      limit: 5,
    },
    headers: {
      "Content-Type": "application/json",
    },
  });

  // return
  return NextResponse.json(
    { payload: res.data.suggestions },
    { status: res.status, statusText: res.statusText }
  );
}
