import { NextApiRequest, NextApiResponse } from 'next'
import POST from './_post'
import GET from './_get'
import PUT from './_put'
import DELETE from './_delete'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    const { method } = req
    switch (method) {

        // 포스팅 조회
        case 'GET':
            await GET(req, res)
            break

        // 포스팅 생성
        case 'POST':
            await POST(req, res)
            break

        // 포스팅 삭제
        case 'PUT':
            await PUT(req, res)
            break

        // 포스팅 삭제
        case 'DELETE':
            await DELETE(req, res)
            break

        default:
            res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE'])
            res.status(405).end(`Method ${method} Not Allowed`)
    }
}
