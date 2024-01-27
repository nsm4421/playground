import axios from "axios";
import { NextApiRequest, NextApiResponse } from "next";

type Data = {
  message: string;
  data: {
    token:string
  };
};

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  const { username, password } = JSON.parse(req.body);
  axios
    .post("http://localhost:8080/api/user/login", {
      username,
      password,
    })
    .then((res) => res.data)
    .then((data) => res.status(200).json(data))
    .catch((err) => res.status(500).json(err.response.data??{message:"Error Occurs While Login", data:null}));
}
