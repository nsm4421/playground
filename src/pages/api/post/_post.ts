import { NextApiRequest, NextApiResponse } from "next";
import { getServerSession } from "next-auth";
import { authOptions } from "../auth/[...nextauth]";
import prisma from "../../../../prisma/prisma_client";

export default async function POST(req: NextApiRequest, res: NextApiResponse) {
    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ message: '인증되지 않은 사용자입니다' });
            return
        }

        // 포스팅 데이터 저장
        const { content, hashtags, images } = req.body
        await prisma.post.create({
            data: {
                content, hashtags, images: images,
                authorId: session.user.id
            }
        })

        res.status(200).json({ message: "success to save post" })
    } catch (err) {
        // 에러처리
        res.status(500).json({ message: "internal server error" })
    }
}
