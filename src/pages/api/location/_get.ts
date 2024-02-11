import { NextApiRequest, NextApiResponse } from "next"
import Coordinate2Address from "./_coordinate2address"


export default async function GET(req: NextApiRequest, res: NextApiResponse) {
    const { type } = req.query
    switch (type) {
        case "coordinate2address":
            Coordinate2Address(req, res)
            break
        
        default:
            res.status(422).end(`type parameter is not valid(it is given by ${type})`);
    }
}