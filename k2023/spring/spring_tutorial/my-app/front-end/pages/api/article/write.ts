import type { NextApiRequest, NextApiResponse } from "next";
import axios from "axios";

type Data = {
  message: string;
};

async function writeARticle({
  title,
  content,
  hashtags,
  token,
}: {
  title: string;
  content: string;
  hashtags: string[];
  token: string;
}) {
  try {
    const res = await axios.post(
      "http://localhost:8080/api/article",
      {
        title,
        content,
        hashtags,
      },
      {
        headers: {
          Authorization: token
        },
      }
    );
    return res;
  } catch (e) {
    console.error(JSON.stringify(e));
  }
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  try {
    const r = await writeARticle(JSON.parse(req.body));
    if (r){
        res.status(200).json({ message: r.data.message});
        return;
    }
    res.status(500).json({ message: "Fail" });
  } catch (e) {
    console.error(e);
    return res.status(400).json({ message: "Write article fail" });
  }
}
