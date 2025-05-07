import axios from "axios";
import { NextApiRequest, NextApiResponse } from "next";

type Data = {
  message: String;
  data: {
    username: String;
    email: String;
    memo: String | null;
  };
};

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  const { username, password, email } = JSON.parse(req.body);
  axios
    .post("http://localhost:8080/api/user/signup", {
      username,
      password,
      email,
    })
    .then((res) => res.data)
    .then((data) => res.status(200).json(data))
    .catch((err) => res.status(500).json(err.response.data));
}
