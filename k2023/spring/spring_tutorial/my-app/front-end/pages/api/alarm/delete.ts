import axios from "axios";
import { NextApiRequest, NextApiResponse } from "next";

type Data = {
  message: string;
};

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  const { id } = req.query;
  const token = req.headers.authorization;
  axios
    .delete(`http://localhost:8080/api/alarm?id=${id}`, {
      headers: {
        Authorization: token,
      },
    })
    .then((r) => res.status(200).json({message:"Success to delete alarm"}))
    .catch((err) =>
      res.status(500).json(
        err.response.data ?? {
          message: "Faile to delete alarm",
        }
      )
    );
}
