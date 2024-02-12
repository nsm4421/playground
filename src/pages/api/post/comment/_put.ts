import { NextApiRequest, NextApiResponse } from "next"
import { getServerSession } from "next-auth"
import { authOptions } from "../../auth/[...nextauth]"
import prisma from "../../../../../prisma/prisma_client"

interface RequestProps {
    commentId: string
    content: string
}

interface ResponseProps {
    message: string
}

export default async function PUT(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {
    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ message: '인증되지 않은 사용자입니다' })
            return
        }

        // 포스팅 존재여부 검사
        const { content, commentId }: RequestProps = req.body
        const comment = await prisma.comment.findUniqueOrThrow({
            where: {
                id: commentId
            }
        })

        // 수정요청한 사람과 작성자가 동일한지 확인
        if (comment.authorId !== session.user.id) {
            console.error("다른 사람이 작성한 게시글을 수정하려고 하려는 요청")
            res.status(403).json({ message: 'forbidden request for modifying post' })
            return
        }

        // 본문 업데이트
        await prisma.comment.update({
            where: {
                id: commentId
            }, data: {
                ...comment, content
            }
        })

        res.status(200).json({ message: 'success to save comment' })
    } catch (err) {
        console.error(err)
        res.status(500).json({ message: 'internal server error' })
    }
}