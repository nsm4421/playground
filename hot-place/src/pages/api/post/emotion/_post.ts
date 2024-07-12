import { NextApiRequest, NextApiResponse } from "next"
import { getServerSession } from "next-auth"
import { authOptions } from "../../auth/[...nextauth]"
import prisma from "../../../../../prisma/prisma_client"

interface PostRequestProps {
    postId: string
}

interface ResponseProps {
    message: string
}

export default async function POST(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {
    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ message: '인증되지 않은 사용자입니다' })
            return
        }
        const userId = session.user.id

        // 좋아요 추가
        const { postId }: PostRequestProps = await req.body
        await prisma.emotion.create({
            data: {
                userId,
                postId
            }
        })

        res.status(200).json({ message: "success to create like" })
    } catch (err) {
        // 에러처리
        res.status(500).json({ message: "internal server error" })
    }
}