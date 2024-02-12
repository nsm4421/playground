import { NextApiRequest, NextApiResponse } from "next";
import { getServerSession } from "next-auth";
import { authOptions } from "../../auth/[...nextauth]";
import prisma from "../../../../../prisma/prisma_client";



export default async function DELETE(req: NextApiRequest, res: NextApiResponse) {

    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ message: '인증되지 않은 사용자입니다' });
            return
        }
        const userId = session.user.id

        // 좋아요 삭제
        const postId = req.query.postId as string
        const { count } = await prisma.emotion.deleteMany({
            where: {
                postId,
                userId
            },
        })

        if (count) {
            res.status(200).json({ message: "success to delete like" })
        } else {
            res.status(201).json({ message: "nothing to delete" })
        }


    } catch (err) {
        // 에러처리
        res.status(500).json({ message: "internal server error" })
    } 
}