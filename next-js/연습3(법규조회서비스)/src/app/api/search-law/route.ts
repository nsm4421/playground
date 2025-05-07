import { genApiResponse } from "@/lib/gen-api-response";
import { NextRequest } from "next/server";
import { History } from "@/types/law";

type RemoteApiResponse = {
  LawSearch: {
    law: History[];
    page: string;
    resultCode: string;
    totalCnt: string;
    numOfRows: string;
    resultMsg: string;
  };
};

type ResponseData = {
  법령ID: string;
  법령명한글: string;
  개정이력: History[];
}[];

export type ApiResponseType = {
  data: ResponseData;
  message: string;
  status: number;
};

async function remoteApiCall(
  query: string,
  page: number
): Promise<RemoteApiResponse> {
  const baseUrl = "http://www.law.go.kr/DRF/lawSearch.do";
  const endPoint = `${baseUrl}?target=eflaw&type=JSON&query=${query}&OC=${process.env.OC}&page=${page}`;
  const res = await fetch(endPoint);
  return await res.json();
}

export async function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams;
  const query = searchParams.get("query");
  if (!query) {
    console.error("query is not given");
    return genApiResponse({ message: "법령ID가 주어지지 않음", status: 403 });
  }

  try {
    // 전체 페이지수 구하기
    let r = await remoteApiCall(query, 1);
    const totalCnt = Number(r.LawSearch.totalCnt);
    const numOfRows = Number(r.LawSearch.numOfRows);
    const totalPage = Math.ceil(totalCnt / numOfRows);

    // 에러인 경우
    if (r.LawSearch.resultCode != "00" || totalCnt === 0) {
      return genApiResponse<void>({
        message: "조회된 법령이 없습니다",
        status: 404,
      });
    }

    // 전체 데이터 조회하기
    let data: ResponseData = [];
    for (let idx = 1; idx <= totalPage; idx++) {
      const rawData = await remoteApiCall(query, idx).then(
        (r) => r.LawSearch.law
      );
      for (const e of rawData) {
        const idx = data.findIndex((d) => d.법령ID === e.법령ID);
        if (idx === -1) {
          data.push({
            법령ID: e.법령ID,
            법령명한글: e.법령명한글,
            개정이력: [e],
          });
        } else {
          data[idx].개정이력.push(e);
        }
      }
    }

    return genApiResponse<ResponseData>({
      data,
      message: `got ${data.length} histories`,
      status: 200,
    });
  } catch (error) {
    console.error(error);
    return new Response(null, { status: 500 });
  }
}
