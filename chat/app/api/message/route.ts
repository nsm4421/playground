import type { NextApiRequest, NextApiResponse } from "next";
import GET from "./get";
import POST from "./post";
import DELETE from "./delete";

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  switch (req.method) {
    case "GET":
      GET(req, res);
      break;
    case "POST":
      POST(req, res);
      break;
    case "DELETE":
      DELETE(req, res);
      break;
    default:
      res.status(404).json({ message: "not valid http method" });
  }
}
