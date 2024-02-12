import { NextApiRequest, NextApiResponse } from "next"
import POST from "./_post"
import GET from "./_get"
import DELETE from "./_delete"

export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    const { method } = req
    switch (method) {
        // 좋아요 개수 가져오기
        case 'GET':
            await GET(req, res)
            break

        // 좋아요 생성
        case 'POST':
            await POST(req, res)
            break

        // 좋아요 삭제
        case 'DELETE':
            await DELETE(req, res)
            break

        default:
            res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE'])
            res.status(405).end(`Method ${method} Not Allowed`)
    }
}