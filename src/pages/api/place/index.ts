import { NextApiRequest, NextApiResponse } from 'next';
import POST from './_post';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    const { method } = req;

    switch (method) {

        case 'GET':

        // 핫플 생성
        case 'POST':
            POST(req, res)
            break

        // TODO : 핫플 수정
        case 'PUT':

        // TODO : 핫플 삭제
        case 'DELETE':
            
        default:
            res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
            res.status(405).end(`Method ${method} Not Allowed`);
    }
}
