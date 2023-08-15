import axios from "axios";
import { NextApiRequest, NextApiResponse } from "next";

type Data = {
  message: string;
  data: string;
};

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  const token = req.headers.authorization;
  axios
    .get(`http://localhost:8080/api/user/username`, {
      headers: {
        Authorization: token,
      },
    })
    .then((res) => res.data.data)
    .then((data) => ({ message: "Success to get alarms", data }))
    .then((data) => res.status(200).json(data))
    .catch((err) =>
      res.status(500).json(
        err.response.data ?? {
          message: "Faile to get username",
          data: null,
        }
      )
    );
}
