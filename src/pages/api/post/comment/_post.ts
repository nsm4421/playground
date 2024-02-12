import { NextApiRequest, NextApiResponse } from "next"
import { getServerSession } from "next-auth"
import { authOptions } from "../../auth/[...nextauth]"
import prisma from "../../../../../prisma/prisma_client"
import { v4 as uuid } from "uuid"

interface RequestProps {
    content: string
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
        const authorId = session.user.id

        // 게시글 조회
        const { content, postId }: RequestProps = req.body
        const post = await prisma.post.findUniqueOrThrow({where:{id:postId}})
        
        // 부모 댓글 저장
        const id = uuid()
        await prisma.comment.create({
            data: {
                id,
                parentId: id,
                content,
                isParent: true,
                postId,
                authorId
            }
        })

        res.status(200).json({ message: 'success to save comment' })
    } catch (err) {
        console.error(err)
        res.status(500).json({ message: 'internal server error' })
    }
}