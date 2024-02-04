import { NextApiRequest, NextApiResponse } from 'next';
import POST from './_post';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    const { method } = req;
    switch (method) {

        // TODO : 포스팅 삭제
        case 'GET':
            res.status(200).json({ message: 'TODO : 포스팅 단건조회 및 검색' });
            break;

        // 포스팅 생성
        case 'POST':
            await POST(req, res)
            break;

        // TODO : 포스팅 삭제
        case 'PUT':

            res.status(200).json({ message: 'TODO : 포스팅 삭제' });
            break;

        // TODO : 포스팅 삭제
        case 'DELETE':
            res.status(200).json({ message: 'TODO : 포스팅 삭제' });
            break;

        default:
            res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
            res.status(405).end(`Method ${method} Not Allowed`);
    }
}
