import { NextApiRequest, NextApiResponse } from 'next';
import GET from './_get';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    const { method } = req;

    switch (method) {

        // 좌표 -> 도로명 주소
        case 'GET':
            GET(req, res)
            break

        // 
        case 'POST':

        // TODO 
        case 'PUT':

        // TODO 
        case 'DELETE':

        default:
            res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
            res.status(405).end(`Method ${method} Not Allowed`);
    }
}
