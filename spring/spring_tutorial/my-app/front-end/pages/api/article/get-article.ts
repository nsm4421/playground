import { Article } from "@/utils/model";
import axios from "axios";
import { NextApiRequest, NextApiResponse } from "next";

type Data = {
  message: string;
  data: Article;
};

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  const { id } = req.query;
  axios
    .get(`http://localhost:8080/api/article/${id}`)
    .then((res) => res.data)
    .then((data) => ({ message: "Success to get article", data }))
    .then((data) => res.status(200).json(data))
    .catch((err) =>
      res.status(500).json(
        err.response.data ?? {
          message: "Faile to get article messages",
          data: null,
        }
      )
    );
}
