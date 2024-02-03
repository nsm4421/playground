import { NextApiRequest, NextApiResponse } from "next";
import { POST } from "./_post";

export type SignUpResponse = {
  message: string;
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<SignUpResponse>
) {
  try {
    const method = req.method
    switch (method) {
      case "POST":
        await POST(req, res)
        return;

    }
    res.status(404).json({ message: 'endpoint not found' })
  } catch (err) {
    res.status(500).json({ message: 'internal server error' })
  }
}