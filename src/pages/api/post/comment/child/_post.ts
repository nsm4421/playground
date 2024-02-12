import { authOptions } from "@/pages/api/auth/[...nextauth]"
import { NextApiRequest, NextApiResponse } from "next"
import { getServerSession } from "next-auth"
import prisma from "../../../../../../prisma/prisma_client"

interface RequestProps {
    content: string
    parentId: string
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
        const authorId = session.user.id
        const { content, parentId }: RequestProps = req.body

        // 부모 댓글 조회
        const parentComment = await prisma.comment.findUniqueOrThrow({ where: { id: parentId } })

        // 자식 댓글 저장
        await prisma.comment.create({
            data: {
                parentId: parentId,
                content,
                isParent: false,
                postId: parentComment.postId,
                authorId
            }
        })

        res.status(200).json({ message: 'success to save comment' })
    } catch (err) {
        console.error(err)
        res.status(500).json({ message: 'internal server error' })
    }
}