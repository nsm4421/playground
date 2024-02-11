import { NextApiRequest, NextApiResponse } from 'next';
import Coordinate2Address from './_coordinate2address';
import GET from './_get';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    const { method } = req;

    switch (method) {

        // 핫플 조회
        case 'GET':
            GET(req, res)
            break

        // 핫플 생성
        case 'POST':

        // TODO : 핫플 수정
        case 'PUT':
            res.status(200).json({ message: 'TODO : 포스팅 삭제' });
            break;

        // TODO : 핫플 삭제
        case 'DELETE':
            res.status(200).json({ message: 'TODO : 포스팅 삭제' });
            break;

        default:
            res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
            res.status(405).end(`Method ${method} Not Allowed`);
    }
}
