import { NextApiRequest, NextApiResponse } from 'next'
import POST from './_post'
import GET from './_get'


export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    const { method } = req
    switch (method) {

        // 자식 댓글 목록 조회
        case 'GET':
            await GET(req, res)
            break

        // 자식 댓글 작성
        case 'POST':
            await POST(req, res)
            break

        default:
            res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE'])
            res.status(405).end(`Method ${method} Not Allowed`)
    }
}
