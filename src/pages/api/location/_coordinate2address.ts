import { NextApiRequest, NextApiResponse } from "next"
import axios from "axios";
import { RoadAdress } from "@/util/constant/location";

interface ResponseType {
    total_count: number;
    addresses: RoadAdress[];
    message: string;
}

/**
 * 위경도 좌표를 통해 도로명 주소 조회
 * @param req
 * -- x : 위도
 * - y : 경도
 * @param res
 * -- total_count 전체 조회 자료 개수
 * - addresses 전체 조회 자료 개수
 * - message 메세지
 */
export default async function Coordinate2Address(req: NextApiRequest, res: NextApiResponse<ResponseType>) {
    try {
        // 위경도
        const { x, y } = req.query

        // 데이터 조회
        const { data: { meta: { total_count }, documents } } = await axios.get(`https://dapi.kakao.com/v2/local/geo/coord2address?x=${x}&y=${y}`, {
            headers: {
                Authorization: `KakaoAK ${process.env.KAKAO_CLIENT_ID}`
            }
        })

        // 도로명 주소
        const addresses = documents.map((doc: { road_address: any; }) => ({
            ...doc.road_address
        }))

        res.status(200).json({ total_count, addresses, message: 'success to get address from coordinate' })
    } catch (err) {
        res.status(500).json({ total_count: 0, addresses: [], message: 'fail to get address' })
    }
}