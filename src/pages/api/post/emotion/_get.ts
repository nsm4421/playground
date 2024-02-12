import { NextApiRequest, NextApiResponse } from "next"
import prisma from "../../../../../prisma/prisma_client"
import { getServerSession } from "next-auth"
import { authOptions } from "../../auth/[...nextauth]"

interface ResponseProps {
    postId: string
    count?: number
    isLike?: boolean
    message?: string
}

export default async function GET(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {


    const postId = req.query.postId as string
    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ postId, message: '인증되지 않은 사용자입니다' })
            return
        }
        const userId = session.user.id

        // 유저가 좋아요를 누른 게시글인지 여부
        const isLike = await prisma.emotion.count({
            where: {
                postId, userId
            }
        }) > 0

        const count = await prisma.emotion.count({
            where: {
                postId
            }
        })
        res.status(200).json({ postId, isLike, count, message: 'success to get like count' })
    } catch (err) {
        res.status(500).json({ postId, message: 'internal server error' })
    }
}